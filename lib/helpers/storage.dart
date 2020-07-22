import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:uuid/uuid.dart';

enum StorageType {
  META_COVER,
  CONTENT_COVER
}

class Storage {
  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  static Future<String> uploadImageToStorage(StorageType type, String id, File image) async {
    final storagePath = 
      (type == StorageType.META_COVER) ? 'cover/$id/${Uuid().v4()}' :'content/$id/cover/${Uuid().v4()}';
      

    final StorageReference storageReference = _firebaseStorage.ref().child(storagePath);
    final StorageUploadTask storageUploadTask = storageReference.putFile(image);
    await storageUploadTask.onComplete;
    String downloadUrl = await storageReference.getDownloadURL();
    return downloadUrl;
  }

  static Future<String> uploadContentImage(String id, Asset asset) async {
    ByteData byteData = await asset.getByteData();
    List<int> imageData = byteData.buffer.asUint8List();
    final StorageReference storageReference = _firebaseStorage.ref().child('content/$id/item/${Uuid().v4()}');
    final StorageUploadTask storageUploadTask = storageReference.putData(imageData);
    await storageUploadTask.onComplete;
    String downloadUrl = await storageReference.getDownloadURL();
    return downloadUrl;
  }
}