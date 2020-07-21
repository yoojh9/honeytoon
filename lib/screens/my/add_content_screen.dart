import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:honeytoon/widgets/cover_img_widget.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import '../../helpers/db.dart';
import 'package:image_picker/image_picker.dart';
import '../../helpers/storage.dart';
import '../../models/honeytoonMeta.dart';

class AddContentScreen extends StatefulWidget {
  static final routeName = 'add-content';

  @override
  _AddContentScreenState createState() => _AddContentScreenState();
}

class _AddContentScreenState extends State<AddContentScreen> {
  final _formKey = GlobalKey<FormState>();
  List<Asset> _images = List<Asset>();
  File coverImage;
  var _error = '';
  final picker = ImagePicker();
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

    String downloadUrl = await Storage.uploadImageToStorage(coverImage);
    print(downloadUrl);
    honeytoonMeta.coverImgUrl = downloadUrl;
    honeytoonMeta.displayName = user.displayName;
    honeytoonMeta.uid = user.uid;

    await DB.addHoneytoonMeta(honeytoonMeta);

    setState(() {
      _isLoading = false;
    });

    Navigator.of(ctx).pop();
  }

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final width = mediaQueryData.size.width -
        (mediaQueryData.padding.right + mediaQueryData.padding.left);
    final height = mediaQueryData.size.height -
        (kToolbarHeight +
            mediaQueryData.padding.top +
            mediaQueryData.padding.bottom);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Flower 1화'),
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
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: CoverImgWidget(coverImage),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        RaisedButton(
                            color: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text('이미지 선택'),
                            onPressed: loadAssets),
                        Expanded(
                          flex: 3,
                          child:
                              _images.length > 0 ? buildGridView() : SizedBox(),
                        )
                      ]),
                ),
              )));
  }
}
