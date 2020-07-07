import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/link.dart';
import './screens/honeytoon_list_screen.dart';
import './screens/auth_screen.dart';
import './providers/auth.dart';
import 'package:provider/provider.dart';

void main() {
  KakaoContext.clientId = "030ba7c59137629e86e8721eb1a22fd6";
  KakaoContext.javascriptClientId = "38549e1d4f65d4c9c19ac37cad047400";
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth()
        )
      ],
      child: MaterialApp(
        title: 'Honey Toon',
        theme: ThemeData(
          primarySwatch: themeColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthScreen(),
        routes: {
          "list": (context) => HoneyToonListScreen()
        },
        ),
      );
  }
}

const MaterialColor themeColor = MaterialColor(0XFFFFBE42,
  <int, Color>{
    50: Color(0XFFFFBE42),
    100: Color(0XFFFFBE42),
    200: Color(0XFFFFBE42),
    300: Color(0XFFFFBE42),
    400: Color(0XFFFFBE42),
    500: Color(0XFFFFBE42),
    600: Color(0XFFFFBE42),
    700: Color(0XFFFFBE42),
    800: Color(0XFFFFBE42),
    900: Color(0XFFFFBE42),
  });