import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/honeytoonMeta.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class DB {
  static final _db = Firestore.instance;

  static Future<void> addHoneytoonMeta(HoneytoonMeta meta) async {
    final workId = Uuid().v4();
    await _db.collection('toons').document(workId).setData({
      'uid': meta.uid,
      'displayName': meta.displayName,
      'total_count': 0,
      'title': meta.title,
      'description': meta.description,
      'cover_img': meta.coverImgUrl,
      'create_time': DateTime.now()
    });

    await _db.collection('users').document(meta.uid).updateData({
      'works': FieldValue.arrayUnion([workId])
    });
  }

  static Future<List<HoneytoonMeta>> getHoneytoonMeta(String workId) async {
    final list = await _db.collection('toons').document(workId).get();
  }

  static Stream<QuerySnapshot> getHoneytoonList(){
    
    return _db.collection('toons').getDocuments().asStream();
    //   .then((QuerySnapshot snapshot) {
    //     snapshot.documents.forEach((honeytoon) {
    //       list.add(HoneytoonMeta(workId: honeytoon.documentID, 
    //         uid: honeytoon.data['uid'], 
    //         coverImgUrl: honeytoon.data['cover_img'], 
    //         totalCount: honeytoon.data['total_count'],
    //         title: honeytoon.data['title'],
    //         description: honeytoon.data['description']));
    //     });
    //   });
    // return list;
  }

}