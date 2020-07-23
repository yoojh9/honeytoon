import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/honeytoonContentItem.dart';
import '../models/honeytoonContent.dart';
import '../helpers/collections.dart';

class HoneytoonContentProvider extends ChangeNotifier {
  static final _firestore = Firestore.instance;
  static final _contentRef = _firestore.collection(Collections.CONTENT);
  static final _metaRef = _firestore.collection(Collections.TOON);

  Future<List<HoneytoonContentItem>> getHoneytoonContentList(String toonId) async {
    List<HoneytoonContentItem> _items;

    QuerySnapshot result = await _contentRef.document(toonId).collection('items').orderBy('create_time' ,descending: true).getDocuments();
    _items = result.documents
      .map((document) => HoneytoonContentItem.fromMap(document.documentID, document.data))
      .toList();

    return _items;
  }

  Future<void> createHoneytoonContent(HoneytoonContent content) async {
    Map data = content.toJson();
    final DocumentReference contentReference = _contentRef.document(content.toonId)
        .collection('items').document();
    final DocumentReference metaReference = _metaRef.document(content.toonId);

    _firestore.runTransaction((transaction) async {
      await transaction.set(contentReference, data);
      await transaction.update(metaReference, {'total_count': content.count});
    }).then((_){
      print('success');
    }).catchError((error){
      print(error.message);
    });
  }

  // Future<void> updateHoneytoonMeta(HoneytoonMeta meta) async {
  //   Map data = meta.toJson();
  //   DocumentReference document = await _api.updateDocument(meta.workId, data);
  // }

  Stream<QuerySnapshot> streamMeta() {
    return _contentRef.getDocuments().asStream();
  }
}
