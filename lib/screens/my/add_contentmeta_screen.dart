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

class AddContentMetaScreen extends StatefulWidget {
  static final routeName = 'add-contentmeta';

  @override
  _AddContentMetaScreenState createState() => _AddContentMetaScreenState();
}

class _AddContentMetaScreenState extends State<AddContentMetaScreen> {
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

    String downloadUrl = await Storage.uploadImageToStorage(StorageType.META_COVER, user.uid, _coverImage);
    honeytoonMeta.coverImgUrl = downloadUrl;
    honeytoonMeta.displayName = user.displayName;
    honeytoonMeta.uid = user.uid;
    honeytoonMeta.createTime = Timestamp.now();
    honeytoonMeta.totalCount = 0;

    _metaProvider.createHoneytoonMeta(honeytoonMeta);

    setState(() {
      _isLoading = false;
    });

    Navigator.of(ctx).pop();
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
    final mediaQueryData = MediaQuery.of(context);
    final width = mediaQueryData.size.width - (mediaQueryData.padding.right + mediaQueryData.padding.left);
    final height = mediaQueryData.size.height - (kToolbarHeight + mediaQueryData.padding.top + mediaQueryData.padding.bottom);
    _metaProvider = Provider.of<HoneytoonMetaProvider>(context);

    return Scaffold(
        resizeToAvoidBottomInset : false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('작품 추가'),
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
                child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
                child: Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    TextFormField(
                            decoration: InputDecoration(
                              hintText: '작품 제목',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return '작품 명을 입력해주세요';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              honeytoonMeta.title = value;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 2,
                            decoration: InputDecoration(
                                alignLabelWithHint: true, hintText: '작품 설명'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return '작품 설명을 입력해주세요';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              honeytoonMeta.description = value;
                            },
                          ),
                        SizedBox(height: 30),
                        Container(
                          height: height * 0.25,
                          child: CoverImgWidget(_coverImage, setImage)
                        ),
                  ]),
                ),
              )));
  }
}
