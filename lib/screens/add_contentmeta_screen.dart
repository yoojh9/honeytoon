import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../helpers/db.dart';
import 'package:image_picker/image_picker.dart';
import '../helpers/storage.dart';
import '../models/honeytoonMeta.dart';
import '../colors.dart';

class AddContentMetaScreen extends StatefulWidget {

  static final routeName = 'add-contentmeta';

  @override
  _AddContentMetaScreenState createState() => _AddContentMetaScreenState();
}

class _AddContentMetaScreenState extends State<AddContentMetaScreen> {
  final _formKey = GlobalKey<FormState>();
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

  Future<void> _submitForm(BuildContext ctx) async{
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

    Navigator.of(ctx).pop();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final width = mediaQueryData.size.width - (mediaQueryData.padding.right + mediaQueryData.padding.left);
    final height = mediaQueryData.size.height - (kToolbarHeight + mediaQueryData.padding.top + mediaQueryData.padding.bottom);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('작품 추가'),
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 16),
            child : GestureDetector(
              child: Text('완료', textScaleFactor: 1.5, style: TextStyle(fontSize:  12),),
              onTap: (){
                _submitForm(context);
              },
            ),
          )
        ],
      ),
      body: _isLoading 
      ? Center(child: CircularProgressIndicator())
      : SafeArea(    
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _coverImage == null 
                  ? Container(
                    height: height * 0.3,
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
                      height: height * 0.3,
                      width: width * 0.5,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(_coverImage),
                          fit: BoxFit.cover
                        ),
                        borderRadius: BorderRadius.circular(12)
                      ),
                    ),
                SizedBox(height: 30),
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
                SizedBox(height: 15,),
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
              ]
          ),
        ),
      ) 
      )
    );
  }
}