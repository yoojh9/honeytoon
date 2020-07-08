import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';


class AuthScreen extends StatefulWidget {

  @override
  _AuthScreenState createState() => _AuthScreenState();


}

class _AuthScreenState extends State<AuthScreen> {
  void _loginKakao() async {
    final user = await FirebaseAuth.instance.currentUser();
    if(user != null){
      print(user.displayName);
      print(user.email);
      print(user.uid);
      print(user.photoUrl);
      print('already login');
    } else {
      print('kakao login');
      final firebaseUser = await Provider.of<Auth>(context, listen: false).kakaoLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('로그인')),
      body: 
      Padding(
        padding: EdgeInsets.symmetric(vertical:48 , horizontal:16),
        child: Column(
          children: <Widget>[
          Text('SNS 계정으로 로그인 / 가입', style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Container(
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
                    onTap: () => _loginKakao()
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/naver_login_icon.png'),
                      radius: 30,
                      ), 
                    onTap: (){}
                  ),
                ]
              ),
            ),
          ),
          SizedBox(height: 40,),
          Text('이메일로 로그인 / 가입', style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Container(
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
          )

          ],
        ),
      )
        //Center(child: Text('login'),)

    );
  }
}