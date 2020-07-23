
import 'package:cloud_firestore/cloud_firestore.dart';

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