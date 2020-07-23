import 'package:flutter/foundation.dart';
import '../models/honeytoonContentItem.dart';


class HoneytoonContent {
  String toonId;
  int count;
  HoneytoonContentItem content;
  
  HoneytoonContent({@required this.toonId, this.count, this.content});

  Map<String, dynamic> toJson(){
    return this.content.toJson();
  }
}
