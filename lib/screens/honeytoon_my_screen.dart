import 'package:flutter/material.dart';

class HoneytoonMyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double circleRadius = 120.0;
    final mediaQueryData = MediaQuery.of(context);
    final height = mediaQueryData.size.height - (mediaQueryData.padding.top + mediaQueryData.padding.bottom + 50);


    return Scaffold(
        body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Padding(
                    padding:
                    EdgeInsets.only(top: circleRadius / 2.0, ),  ///here we create space for the circle avatar to get ut of the box
                    child: Container(
                      height: height * 0.3,
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
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: circleRadius/2,),
                                Text('유저혀', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),),
                                SizedBox(
                                  height: 25.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Text('작가랭킹', style: TextStyle( fontSize: 18.0,  color: Colors.black54,),),
                                          Text('14위', style: TextStyle( fontSize: 20.0, color: Colors.black87, fontFamily: ''),),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text('작품정보', style: TextStyle( fontSize: 18.0,  color: Colors.black54),),
                                          Text('2개', style: TextStyle( fontSize: 20.0, color: Colors.black87, fontFamily: ''),),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text('꿀단지', style: TextStyle( fontSize: 18.0,  color: Colors.black54),),
                                          Text('12,500꿀', style: TextStyle( fontSize: 20.0, color: Colors.black87, fontFamily: ''),),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                      ),
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
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Center(
                        child: Container(
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/images/four.jpg'),
                            radius: circleRadius
                          )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ]),
        ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemBuilder: (ctx, index) => 
              Padding(padding: const EdgeInsets.all(16),
              child: Container(
                height: height * 0.15,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child:  Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/one.jpg'),
                          fit: BoxFit.cover,
                        )
                      ),
                    ),),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('단짠남녀', style: TextStyle(fontSize:20,),),
                            Text('102화'),
                            Text('3일전'),
                          ]
                        ),
                      )),
                    Expanded(
                      flex: 1,
                      child: Icon(Icons.add))
                  ]
                ),
              ),
            ),
            itemCount: 6,
          ),
        ]
       ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){

        },
        icon: Icon(Icons.add),
        label: Text('작품'),
        backgroundColor: Theme.of(context).primaryColor,),
    );
  }
}