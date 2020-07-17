import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:honeytoon/screens/settings/setting_section.dart';
import './settings/setting_list.dart';
import './settings/setting_tile.dart';
import './auth_screen.dart';

class SettingMyinfoScreen extends StatefulWidget {
  static const routeName = 'setting-myinfo';

  @override
  _SettingMyinfoScreenState createState() => _SettingMyinfoScreenState();
}

class _SettingMyinfoScreenState extends State<SettingMyinfoScreen> {
  var _user;

  Future<FirebaseUser> _getUser() async {
    final user = await FirebaseAuth.instance.currentUser();
    return user;
  }

  void _loginPage(BuildContext ctx) async {
    final authUser = await Navigator.of(ctx).pushNamed(AuthScreen.routeName);

    setState((){
      _user = authUser;
    });
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final height = mediaQueryData.size.height - (kToolbarHeight + mediaQueryData.padding.top + mediaQueryData.padding.bottom);
    

    return Scaffold(
      appBar: AppBar(
        title: Text('프로필'), 
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
        body:
         StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,  
          builder: (_, snapshot) {
            print('hasData: ${!snapshot.hasData}');
            if(!(snapshot.hasData)){
              return Center(
                child:  RaisedButton(
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text('로그인'),
                  onPressed: () => _loginPage(context)),
              );
            } else {
                  return Container(
                  height: height,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/images/one.jpg'),
                              radius: 50,
                            ),
                            Text('유저혀', style: TextStyle(fontSize: 20,)),
                            Text('12000꿀')
                          ],
                        )
                      ),
                      Expanded(
                        flex: 3,
                        child:  SettingList(
                        sections: [
                          SettingsSection(
                            title: '계정',
                            tiles: [
                              SettingsTile(title: '닉네임변경', onTap: (){},),
                              SettingsTile(title: '로그아웃', onTap: _logout),
                              SettingsTile(title: '탈퇴하기', onTap: (){}),
                            ]
                          )
                        ],
                      ))
                    ],
                  ),
              );
            }
          }
         )
         
    );
  }
}