import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/honeytoonMeta.dart';
import 'package:uuid/uuid.dart';

class DB {
  static final _db = Firestore.instance;

  static Future<void> addHoneytoonMeta(HoneytoonMeta meta) async {
    final workId = Uuid().v4();
    await _db.collection('toons').document(meta.uid).setData({
      'id': workId,
      'total_count': 0,
      'title': meta.title,
      'description': meta.description,
      'cover_img': meta.coverImgUrl,
    });

    await _db.collection('users').document(meta.uid).updateData({
      'works': FieldValue.arrayUnion([workId])
    });
  }

  static Future<List<HoneytoonMeta>> getHoneytoonMeta(String uid) async {
    final list = await _db.collection('toons').document(uid).get();
  }

}