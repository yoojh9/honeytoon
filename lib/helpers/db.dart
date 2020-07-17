import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/honeywork.dart';
import 'package:uuid/uuid.dart';

class DB {
  static final _db = Firestore.instance;

  static Future<void> addHoneywork(HoneyWork honeywork) async {
    await _db.collection('works').document(honeywork.uid).setData({
      'id': Uuid().v4(),
      'total_count': 0,
      'title': honeywork.title,
      'description': honeywork.description,
      'cover_img': honeywork.coverImgUrl,
      'work':[]
    });
  }
}