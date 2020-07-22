import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

enum StorageType {
  META_COVER,
  CONTENT_COVER,
  CONTENT
}

class Storage {

  static Future<String> uploadImageToStorage(StorageType type, String id, File image) async {

    final storagePath = 
      (type == StorageType.META_COVER) ? 'cover/$id/${Uuid().v4()}'
      : (type == StorageType.CONTENT_COVER)  ? 'content/$id/cover/${Uuid().v4()}'
      : 'content/$id/item/${Uuid().v4()}';
    final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
    final StorageReference storageReference = _firebaseStorage.ref().child(storagePath);
    final StorageUploadTask storageUploadTask = storageReference.putFile(image);
    await storageUploadTask.onComplete;
    String downloadUrl = await storageReference.getDownloadURL();
    return downloadUrl;
  }
}