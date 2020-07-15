import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';


class AuthScreen extends StatefulWidget {
  static final routeName = 'auth-screen';

  @override
  _AuthScreenState createState() => _AuthScreenState();


}

class _AuthScreenState extends State<AuthScreen> {
  var user;

  void _loginKakao(BuildContext ctx) async {
    user = await FirebaseAuth.instance.currentUser();

    if(user==null){
      user = await Provider.of<Auth>(context, listen: false).kakaoLogin();
    }

    Navigator.of(ctx).pop(user);

  }

  void _loginFacebook(BuildContext ctx) async {
    user = await FirebaseAuth.instance.currentUser();

    if(user==null){
      user = await Provider.of<Auth>(context, listen: false).facebookLogin();
    }

    Navigator.of(ctx).pop(user);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인')
      ),
      body: 
      Padding(
        padding: EdgeInsets.symmetric(vertical:48 , horizontal:16),
        child: Column(
          children: <Widget>[
          Text('SNS 계정으로 로그인 / 가입', style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(
            flex: 1,
            child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/kakao_login_icon.png'),
                      radius: 30,
                      ), 
                    onTap: () => _loginKakao(context)
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/facebook_login_icon.png'),
                      radius: 30,
                      ), 
                    onTap: () => _loginFacebook(context)
                  ),
                  SizedBox(width: 20),

                ]
              ),
            ),
          ),),
          Text('이메일로 로그인 / 가입', style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(
            flex: 2,
            child: Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                TextFormField(decoration: InputDecoration(labelText: "이메일",),),
                TextFormField(decoration: InputDecoration(labelText: "비밀번호"),),
                SizedBox(height: 20,),
                ButtonTheme(
                  minWidth: double.infinity,
                  height: 40,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    
                    child: Text('이메일로 로그인', style: TextStyle(fontSize: 16),),
                    onPressed: (){}),)
              ]
            )
          ),  
          )

          ],
        ),
      )
        //Center(child: Text('login'),)

    );
  }
}