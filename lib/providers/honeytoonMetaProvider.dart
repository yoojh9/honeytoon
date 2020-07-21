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

  Stream<QuerySnapshot> streamMeta() {
    return _api.streamCollection();
  }
}
