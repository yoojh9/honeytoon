import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class HoneytoonContent {
  String toonId;
  int count;
  HoneytoonContentItem content;
  List<HoneytoonContentItem> items;
  
  HoneytoonContent({@required this.toonId, this.count, this.content, this.items});

  HoneytoonContent.fromMap(Map snapshot, String documentId){
    this.toonId = documentId;
    this.items = snapshot['items'].fromMap();
  }

  Map<String, dynamic> toJson(){
    return this.content.toJson();
  }
}

class HoneytoonContentItem {
  String coverImgUrl;
  Timestamp createTime;
  Timestamp updateTime;
  List<String> contentImgUrls;

  HoneytoonContentItem({this.coverImgUrl, this.contentImgUrls});

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['cover_img'] = this.coverImgUrl;
    data['create_time'] = Timestamp.now();
    data['update_time'] = Timestamp.now();
    data['content_imgs'] = this.contentImgUrls;
    return data;
  }
}
