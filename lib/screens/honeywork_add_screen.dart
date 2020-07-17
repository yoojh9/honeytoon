import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../helpers/db.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import '../helpers/storage.dart';
import '../models/honeytoonMeta.dart';
import '../colors.dart';

class HoneytoonAddScreen extends StatefulWidget {

  static final routeName = 'add-honeytoon';

  @override
  _HoneytoonAddScreenState createState() => _HoneytoonAddScreenState();
}

class _HoneytoonAddScreenState extends State<HoneytoonAddScreen> {
  
  final _formKey = GlobalKey<FormState>();
  List<Asset> _images = List<Asset>();
  File _coverImage;
  var _error = '';
  final picker = ImagePicker();
  var _isLoading = false;
  var honeytoonMeta = HoneytoonMeta();

  Future _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _coverImage = File(pickedFile.path);
    });
  }

  Future<void> _submitForm() async{
    final user = await FirebaseAuth.instance.currentUser();
    final _isValid = _formKey.currentState.validate();
    if(!_isValid) return;

    _formKey.currentState.save();
    setState((){
      _isLoading = true;
    });

    String downloadUrl = await Storage.uploadImageToStorage(_coverImage);
    print(downloadUrl);
    honeytoonMeta.coverImgUrl = downloadUrl;

    honeytoonMeta.uid = user.uid;

    await DB.addHoneytoonMeta(honeytoonMeta);

    setState((){
      _isLoading = false;
    });

  }

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(crossAxisCount: 3,
      children: List.generate(_images.length, (index) {
        Asset asset = _images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300);
      }),
    );
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
    } on Exception catch(e){
      error = e.toString();
    }

    if(!mounted) return;

    setState(() {
      _images = resultList;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final width = mediaQueryData.size.width - (mediaQueryData.padding.right + mediaQueryData.padding.left);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('허니툰 추가'),
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 16),
            
            child : GestureDetector(
              child: Text('완료', textScaleFactor: 1.5, style: TextStyle(fontSize:  12),),
              onTap: _submitForm,
              ),
          )
        ],
      ),
      body: _isLoading 
      ? Center(child: CircularProgressIndicator())
      : SafeArea(    
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child :  _coverImage == null 
                  ? Container(
                    width: width * 0.5,
                    decoration: BoxDecoration(
                      color: itemPressedColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(child: FlatButton.icon(
                      onPressed: _getImage, 
                      icon: Icon(Icons.add_a_photo, color: Colors.grey,), 
                      label: Text('커버이미지', style: TextStyle(color: Colors.grey),))
                    )
                  )
                  : Container(
                      width: width * 0.5,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(_coverImage),
                          fit: BoxFit.cover
                        ),
                        borderRadius: BorderRadius.circular(12)
                      ),
                    ),
                ),
                Expanded(
                  flex: 2,
                  child: 
                  Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: '작품 제목',
                      ),
                      validator: (value) {
                        if(value.isEmpty){
                          return '작품 명을 입력해주세요';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        honeytoonMeta.title = value;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        hintText: '작품 설명'
                      ),
                      validator: (value){
                        if(value.isEmpty) {
                          return '작품 설명을 입력해주세요';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value){
                        honeytoonMeta.description = value;
                      },
                    ),
                    RaisedButton(
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text('이미지 선택'),
                      onPressed: loadAssets),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: _images.length > 0 
                  ? buildGridView()
                  : SizedBox(),  
              )
              ]
          ),
        ),
      ) 
      )
    );
  }
}