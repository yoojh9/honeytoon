import 'package:flutter/material.dart';
import 'package:honeytoon/colors.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CoverImgWidget extends StatefulWidget {
  File _coverImage;

  CoverImgWidget(this._coverImage);

  @override
  _CoverImgWidgetState createState() => _CoverImgWidgetState();
}

class _CoverImgWidgetState extends State<CoverImgWidget> {
  final picker = ImagePicker();

  Future _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      widget._coverImage = File(pickedFile.path);
    });
  }


  @override
  Widget build(BuildContext context) {
    return 
    AspectRatio(
      aspectRatio: 1/1,
      child: widget._coverImage == null 
          ? Container(
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
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(widget._coverImage),
                  fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.circular(12)
              ),
            )
      );
    }
}