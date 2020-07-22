import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/honeytoonContent.dart';
import '../services/honeytoon_content_api.dart';

class HoneytoonContentProvider extends ChangeNotifier {
  HoneytoonContentApi _api;
  List<HoneytoonContent> _contents;

  HoneytoonContentProvider(HoneytoonContentApi api) {
    _api = api;
  }

  Future<List<HoneytoonContent>> getHoneytoonContentList() async {
    QuerySnapshot result = await _api.getCollection();
    _contents = result.documents
        .map((document) =>
            HoneytoonContent.fromMap(document.data, document.documentID))
        .toList();
    return _contents;
  }

  Future<void> createHoneytoonContent(HoneytoonContent content) async {
    Map data = content.toJson();
    await _api.setContentDocument(content.toonId, content.count, data);
  }

  // Future<void> updateHoneytoonMeta(HoneytoonMeta meta) async {
  //   Map data = meta.toJson();
  //   DocumentReference document = await _api.updateDocument(meta.workId, data);
  // }

  Stream<QuerySnapshot> streamMeta() {
    return _api.streamCollection();
  }
}
