import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class Storage {
  

  static Future<String> uploadImageToStorage(File image) async {
    final user = await FirebaseAuth.instance.currentUser();
    final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
    final StorageReference storageReference = _firebaseStorage.ref().child('cover/${user.uid}/${Uuid().v4()}');
    final StorageUploadTask storageUploadTask = storageReference.putFile(image);
    await storageUploadTask.onComplete;
    String downloadUrl = await storageReference.getDownloadURL();
    return downloadUrl;
  }
}