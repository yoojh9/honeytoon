import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/honeytoon_meta_provider.dart';
import '../../helpers/storage.dart';
import '../../models/honeytoonMeta.dart';
import '../../widgets/cover_img_widget.dart';

class AddContentScreen extends StatefulWidget {
  static final routeName = 'add-content';

  @override
  _AddContentScreenState createState() => _AddContentScreenState();
}

class _AddContentScreenState extends State<AddContentScreen> {
  HoneytoonMetaProvider _metaProvider; 
  final _formKey = GlobalKey<FormState>();
  List<Asset> _images = List<Asset>();
  File _coverImage;
  var _error = '';
  var _isLoading = false;
  var honeytoonMeta = HoneytoonMeta();

  Future<void> _submitForm(BuildContext ctx) async {
    final user = await FirebaseAuth.instance.currentUser();
    final _isValid = _formKey.currentState.validate();
    if (!_isValid) return;

    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
     // TODO: id 변경
    String downloadUrl = await Storage.uploadImageToStorage(StorageType.CONTENT_COVER, user.uid, _coverImage);
    honeytoonMeta.coverImgUrl = downloadUrl;
    honeytoonMeta.createTime = Timestamp.now();

    _metaProvider.createHoneytoonMeta(honeytoonMeta);

    setState(() {
      _isLoading = false;
    });

    Navigator.of(ctx).pop();
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 6,
        enableCamera: false,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      _images = resultList;
      _error = error;
    });
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(_images.length, (index) {
        Asset asset = _images[index];
        return AssetThumb(asset: asset, width: 300, height: 300);
      }),
    );
  }

  void setImage(coverImage){
    setState(() {
      _coverImage = coverImage;
    });
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    _metaProvider = Provider.of<HoneytoonMetaProvider>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('회차 등록'),
          actions: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 16),
              child: GestureDetector(
                child: Text(
                  '완료',
                  textScaleFactor: 1.5,
                  style: TextStyle(fontSize: 12),
                ),
                onTap: () {
                  _submitForm(context);
                },
              ),
            )
          ],
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: CoverImgWidget(_coverImage, setImage),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('FLOWER', style: Theme.of(context).textTheme.headline6),
                          Text('1화', style: Theme.of(context).textTheme.subtitle1),
                          
                          RaisedButton(
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text('허니툰 선택'),
                              onPressed: loadAssets),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: _images.length > 0 ? buildGridView() : SizedBox(),
                    )
                  ]),
                ),
              )));
  }
}
