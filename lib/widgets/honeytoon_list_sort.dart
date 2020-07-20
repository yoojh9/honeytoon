import 'package:flutter/material.dart';

class HoneytoonListSort extends StatelessWidget {
  const HoneytoonListSort({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
          child: Text('신규순'),
          onTap: (){print('신규순');},
        ),
        SizedBox(width: 10,),
        GestureDetector(
          child: Text('인기순'),
          onTap: (){print('인기순');},
        ),
    ],);
  }
}

