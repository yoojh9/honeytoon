import 'package:flutter/material.dart';
import '../models/user.dart';

class MyHonetoonInfo extends StatelessWidget {
  const MyHonetoonInfo({
    Key key,
    @required this.height,
    @required this.user,
  }) : super(key: key);

  final double height;
  final User user;

  @override
  Widget build(BuildContext context) {
    final double circleRadius = 120.0;
    return Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Padding(
            padding:
            EdgeInsets.only(top: circleRadius/2.0 + 8, bottom: 16, right: 16, left: 16 ),  ///here we create space for the circle avatar to get ut of the box
            child: Container(
              height: height * 0.28,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8.0,
                    offset: Offset(0.0, 5.0),
                  ),
                ],
              ),
              child: Column(
                  children: <Widget>[
                    SizedBox(height: circleRadius/2,),
                    Text(user.displayName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text('작가랭킹', style: TextStyle( fontSize: 18.0,  color: Colors.black54,),),
                              Text("${user.rank==-1? '-': user.rank}위"  , style: TextStyle( fontSize: 20.0, color: Colors.black87, fontFamily: ''),),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text('작품정보', style: TextStyle( fontSize: 18.0,  color: Colors.black54),),
                              Text("${user.works.length==0? '-': user.works.length}개", style: TextStyle( fontSize: 20.0, color: Colors.black87, fontFamily: ''),),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text('꿀단지', style: TextStyle( fontSize: 18.0,  color: Colors.black54),),
                              Text("${user.honey}꿀", style: TextStyle( fontSize: 20.0, color: Colors.black87, fontFamily: ''),),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )
            ),
          ),
          ///Image Avatar
          Container(
            width: circleRadius,
            height: circleRadius,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8.0,
                  offset: Offset(0.0, 5.0),
                ),
              ],
            ),
            child: Center(
                child: Container(
                  padding: EdgeInsets.all(4.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(user.thumbnail),
                    radius: circleRadius
                  )
                ),
              ),
            ),
        ],
      );
  }
}