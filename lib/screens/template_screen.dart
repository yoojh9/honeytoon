import 'package:flutter/material.dart';
import './point/point_template_screen.dart';
import './my/my_screen.dart';
import './honeytoon_list_screen.dart';
import './setting_screen.dart';

class TemplateScreen extends StatefulWidget {
  @override
  _TemplateScreenState createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {
  int _currentIndex = 0;

  final List<Widget> _bodyWidget = [
    HoneyToonListScreen(),
    PointTemplateScreen(),
    MyScreen(),
    SettingScreen()
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 0
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text("허니툰"),
              actions: <Widget>[
                IconButton(icon: Icon(Icons.add), onPressed: () {}),
                IconButton(icon: Icon(Icons.search), onPressed: () {})
              ],
            )
          : null,
      body: _bodyWidget[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                title: Text('Home')),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.attach_money,
                ),
                title: Text('Point')),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                title: Text('My')),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                title: Text('Setting')),
          ],
          currentIndex: _currentIndex,
          onTap: _onTap,
          selectedItemColor: Theme.of(context).primaryColor),
    );
  }
}
