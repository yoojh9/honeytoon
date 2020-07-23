import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class HoneytoonMeta {
  String workId;
  String uid; // userid
  String displayName;
  String coverImgUrl;
  int totalCount;
  String title;
  String description;
  Timestamp createTime;

  HoneytoonMeta(
      {this.workId,
      this.uid,
      this.displayName,
      this.coverImgUrl,
      this.totalCount,
      this.title,
      this.description});

  HoneytoonMeta.fromMap(Map snapshot, String documentId) {
    this.workId = documentId;
    if(snapshot['uid']!=null){
      this.uid = snapshot['uid'];
    }
    this.title = snapshot['title'];
    this.description = snapshot['description'];
    this.displayName = snapshot['displayName'];
    this.coverImgUrl = snapshot['cover_img'];
    this.totalCount = snapshot['total_count'];
    this.createTime = snapshot['create_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(this.uid!=null) {
      data['uid'] = this.uid;
    }
    if(this.title!=null){
      data['title'] = this.title;
    }
    if(this.description!=null){
      data['description'] = this.description;
    }
    if(this.displayName!=null){
      data['displayName'] = this.displayName;
    }
    if(this.coverImgUrl!=null){
      data['cover_img'] = this.coverImgUrl;
    }
    if(this.totalCount!=null){
      data['total_count'] = this.totalCount;
    }
    if(this.createTime!=null){
      data['create_time'] = this.createTime;
    }
    return data;
  }
}
