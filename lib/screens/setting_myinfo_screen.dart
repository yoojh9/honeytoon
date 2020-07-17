import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:honeytoon/models/user.dart';
import '../providers/auth.dart';
import 'package:honeytoon/screens/settings/setting_section.dart';
import 'package:provider/provider.dart';
import './settings/setting_list.dart';
import './settings/setting_tile.dart';
import './auth_screen.dart';

class SettingMyinfoScreen extends StatefulWidget {
  static const routeName = 'setting-myinfo';

  @override
  _SettingMyinfoScreenState createState() => _SettingMyinfoScreenState();
}

class _SettingMyinfoScreenState extends State<SettingMyinfoScreen> {

  Future<User> _getUserInfo(BuildContext ctx) async {
    final user = await Provider.of<Auth>(ctx, listen: false).getUserFromDB();
    return user;
  }

  Future<void> _loginPage(BuildContext ctx) async {
    await Navigator.of(ctx).pushNamed(AuthScreen.routeName);
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
            if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator()
              );
            }
            else if(!(snapshot.hasData)){
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
                  return FutureBuilder(
                    future: Provider.of<Auth>(context, listen: false).getUserFromDB(),
                    builder: (context, futureSnapshot) {
                      if(futureSnapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator()
                        );
                      } else if(!(futureSnapshot.hasData)) {
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
                                      backgroundImage: NetworkImage(futureSnapshot.data.thumbnail),
                                      radius: 40,
                                    ),
                                    Text(futureSnapshot.data.displayName, style: TextStyle(fontSize: 20,)),
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
                    },
                  );
            }
          }
         )
         
    );
  }
}