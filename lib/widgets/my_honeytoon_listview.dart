import 'package:flutter/material.dart';

class MyHoneytoonListView extends StatelessWidget {
  const MyHoneytoonListView({
    Key key,
    @required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemBuilder: (ctx, index) => 
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
          itemCount: 6,
        ),
    );
  }
}