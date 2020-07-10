import 'package:flutter/material.dart';
import './honeytoon_view_screen.dart';
import './honeytoon_detail_screen.dart';

class HoneyToonListScreen extends StatefulWidget {
  @override
  _HoneyToonListScreenState createState() => _HoneyToonListScreenState();
}

class _HoneyToonListScreenState extends State<HoneyToonListScreen> {

  final List<String> _listItem = [
    'assets/images/two.jpg',
    'assets/images/three.jpg',
    'assets/images/four.jpg',
    'assets/images/five.jpg',
    'assets/images/one.jpg',
    'assets/images/two.jpg',
    'assets/images/three.jpg',
    'assets/images/four.jpg',
    'assets/images/five.jpg',
  ];

  void _onTabEvent(BuildContext ctx){
    Navigator.of(ctx).pushNamed(HoneytoonDetailScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: size.height * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage('assets/images/one.jpg'),
                    fit: BoxFit.cover
                  )
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      colors: [
                        Colors.black.withOpacity(.4),
                        Colors.black.withOpacity(.2),
                      ]
                    )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text("Lifestyle Sale", style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),),
                      SizedBox(height: 30,),
                      Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                        ),
                        child: Center(child: Text("Shop Now", style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold),)),
                      ),
                      SizedBox(height: 30,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    child: Text('신규순'),
                    onTap: (){print('신규순');},
                  ),
                  SizedBox(width: 5,),
                  GestureDetector(
                    child: Text('인기순'),
                    onTap: (){print('인기순');},
                  ),
              ],),
              SizedBox(height: 10),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: _listItem.map((item) => GestureDetector(
                    onTap: (){_onTabEvent(context);},
                      child: Card(
                        color: Colors.transparent,
                        elevation: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage(item),
                              fit: BoxFit.cover
                            )
                          ),
                          child: Transform.translate(
                            offset: Offset(50, -50),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 65, vertical: 63),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white
                              ),
                              child: Icon(Icons.bookmark_border, size: 15,),
                            ),
                          ),
                        ),
                      ),
                  )).toList(),
                )
              ),
            ],
          ),
        ),
      );
  }
}