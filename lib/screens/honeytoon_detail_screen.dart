import 'package:flutter/material.dart';

class HoneytoonDetailScreen extends StatelessWidget {
  static final routeName = 'honeytoon-detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('03'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/images/capture.jpeg'),
                Image.asset('assets/images/capture2.jpeg')
              ]
            ),
          )
        ),
      );
  }
}