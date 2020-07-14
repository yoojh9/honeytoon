import 'package:flutter/material.dart';

class HoneytoonAddScreen extends StatefulWidget {

  @override
  _HoneytoonAddScreenState createState() => _HoneytoonAddScreenState();
}

class _HoneytoonAddScreenState extends State<HoneytoonAddScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('허니툰 추가'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '작품 제목'
                )
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '작품 설명'
                )
              ),
            ]
          ),
        ),
      ) 
        
    );
  }
}