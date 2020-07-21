import 'package:flutter/material.dart';
import './honeytoon_my_screen.dart';
import '../honeytoon_favorite_screen.dart';

class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              color: Colors.transparent,
              child: SafeArea(
                child: TabBar(
                  controller: _controller,
                  tabs: <Widget>[
                    Tab(text: 'my툰'),
                    Tab(text: '관심툰'),
                    Tab(text: '최근본'),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            controller: _controller,
            children: <Widget>[
              HoneytoonMyScreen(),
              HoneytoonFavoriteScreen(),
              Center(child: Text('최근본'))
            ],
          ),
        ));
  }
}
