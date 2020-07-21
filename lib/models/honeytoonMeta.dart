import 'package:cloud_firestore/cloud_firestore.dart';

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
    this.uid = snapshot['uid'];
    this.title = snapshot['title'];
    this.description = snapshot['description'];
    this.displayName = snapshot['displayName'];
    this.coverImgUrl = snapshot['cover_img'];
    this.totalCount = snapshot['total_count'];
    this.createTime = snapshot['create_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['title'] = this.title;
    data['description'] = this.description;
    data['displayName'] = this.displayName;
    data['cover_img'] = this.coverImgUrl;
    data['total_count'] = this.totalCount;
    data['create_time'] = this.createTime;
    return data;
  }
}
