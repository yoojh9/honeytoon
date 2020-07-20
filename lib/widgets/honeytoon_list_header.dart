import 'package:flutter/material.dart';

class HoneytoonListHeader extends StatelessWidget {
  const HoneytoonListHeader({
    Key key,
    @required this.height,
  }) : super(key: key);

  final height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      width: double.infinity,
      height: height * 0.3,
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
            SizedBox(height: height * 0.3 * 0.1,),
            Container(
              height: height * 0.3 * 0.2,
              margin: EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
              ),
              child: Center(child: Text("Shop Now", style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold),)),
            ),
            SizedBox(height: height * 0.3 * 0.15,),
          ],
        ),
      ),
    );
  }
}