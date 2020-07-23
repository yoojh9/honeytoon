import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:honeytoon/models/honeytoonContentList.dart';
import '../models/honeytoonContent.dart';
import '../helpers/collections.dart';

class HoneytoonContentProvider extends ChangeNotifier {
  static final _firestore = Firestore.instance;
  static final _contentRef = _firestore.collection(Collections.CONTENT);
  static final _metaRef = _firestore.collection(Collections.TOON);

  List<HoneytoonContentList> _contents;

  Future<List<HoneytoonContentList>> getHoneytoonContentList() async {
    QuerySnapshot result = await _contentRef.getDocuments();
    _contents = result.documents
        .map((document) =>
            HoneytoonContentList.fromMap(document.data, document.documentID))
        .toList();
    return _contents;
  }

  Future<void> createHoneytoonContent(HoneytoonContent content) async {
    Map data = content.toJson();
    final DocumentReference contentReference = _contentRef.document(content.toonId)
        .collection('items').document(content.count.toString());
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
