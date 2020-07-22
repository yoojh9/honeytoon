import 'package:flutter/material.dart';
import 'package:honeytoon/colors.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CoverImgWidget extends StatelessWidget {
  File coverImage;
  Function setImage;

  CoverImgWidget(this.coverImage, this.setImage);

  Future _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    coverImage = File(pickedFile.path);
    setImage(coverImage);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1/1,
      child: coverImage == null 
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
                image: FileImage(coverImage),
                fit: BoxFit.cover
              ),
              borderRadius: BorderRadius.circular(12)
            ),
          )
    );
  }
}
