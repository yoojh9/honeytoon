import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../helpers/collections.dart';
import '../models/honeytoonMeta.dart';

class HoneytoonMetaProvider extends ChangeNotifier {
  static final _firestore = Firestore.instance;
  static final _metaRef = _firestore.collection(Collections.TOON);
  static final _userRef = _firestore.collection(Collections.USER);
  List<HoneytoonMeta> _metaList;

  Future<List<HoneytoonMeta>> getHoneytoonMetaList() async {
    QuerySnapshot result = await _metaRef.getDocuments();
    _metaList = result.documents
        .map((document) =>
            HoneytoonMeta.fromMap(document.data, document.documentID))
        .toList();
    return _metaList;
  }

  Future<HoneytoonMeta> getHoneytoonMeta(String id) async {
    DocumentSnapshot snapshot = await _metaRef.document(id).get();
    HoneytoonMeta honeytoonMeta = HoneytoonMeta.fromMap(snapshot.data, snapshot.documentID);
    return honeytoonMeta;
  }

  Future<void> createHoneytoonMeta(HoneytoonMeta meta) async {
    Map data = meta.toJson();
    final DocumentReference metaReference = _metaRef.document();
    final DocumentReference userReference = _userRef.document(meta.uid);

    _firestore.runTransaction((transaction) async {
      await transaction.set(metaReference, data);
      await transaction.update(userReference, {'works':  FieldValue.arrayUnion([metaReference.documentID]) });
    }).then((_){
      print('success');
    }).catchError((error){
      print(error.message);
    });
  }

  Future<void> updateHoneytoonMeta(HoneytoonMeta meta) async {
    Map data = meta.toJson();
     await _metaRef.document(meta.workId).updateData(data);
  }

  Stream<QuerySnapshot> streamMeta() {
    return _metaRef.getDocuments().asStream();
  }
}
