import 'package:cloud_firestore/cloud_firestore.dart';

class HoneytoonContent {
  String toonId;
  List<HoneytoonContentItem> contents;
  
  
}

class HoneytoonContentItem {
  String coverImgUrl;
  Timestamp createTime;
  Timestamp updateTime;
  List<ContentImage> contentImages;

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cover_img'] = this.coverImgUrl;
    data['create_time'] = Timestamp.now();
    data['update_time'] = Timestamp.now();
    data['contents'] = this.contentImages;
  }
}

class ContentImage {
  String contentImgUrl;
}