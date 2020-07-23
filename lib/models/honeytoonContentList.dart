import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import './honeytoonContentItem.dart';

class HoneytoonContentList {
  String toonId;
  int count;
  List<HoneytoonContentItem> items;
  
  HoneytoonContentList({@required this.toonId, this.count, this.items});

  HoneytoonContentList.fromMap(Map snapshot, String documentId){
    this.toonId = documentId;
    this.items = snapshot['items'].fromMap();
  }
}


