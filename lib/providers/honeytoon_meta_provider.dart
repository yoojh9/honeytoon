import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:honeytoon/services/honeytoon_meta_api.dart';
import '../models/honeytoonMeta.dart';

class HoneytoonMetaProvider extends ChangeNotifier {
  HoneytoonMetaApi _api;
  List<HoneytoonMeta> _metaList;

  HoneytoonMetaProvider(HoneytoonMetaApi api) {
    _api = api;
  }

  Future<List<HoneytoonMeta>> getHoneytoonMetaList() async {
    QuerySnapshot result = await _api.getCollection();
    _metaList = result.documents
        .map((document) =>
            HoneytoonMeta.fromMap(document.data, document.documentID))
        .toList();
    return _metaList;
  }

  Future<void> createHoneytoonMeta(HoneytoonMeta meta) async {
    Map data = meta.toJson();
    DocumentReference document = await _api.addDocument(data);
  }

  Future<void> updateHoneytoonMeta(HoneytoonMeta meta) async {
    Map data = meta.toJson();
    DocumentReference document = await _api.updateDocument(meta.workId, data);
  }

  Stream<QuerySnapshot> streamMeta() {
    return _api.streamCollection();
  }
}
