import 'package:flutter/material.dart';
import 'package:honeytoon/screens/settings/setting_section.dart';
import './settings/setting_list.dart';
import './settings/setting_tile.dart';
import './setting_myinfo_screen.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool lockInBackground = true;
  bool notificationsEnabled = true;


  @override
  Widget build(BuildContext context) {

    return SettingList(
          sections: [
            SettingsSection(
              title: '내 정보',
              tiles: [
                SettingsTile(title: '프로필 설정', onTap: (){Navigator.of(context).pushNamed(SettingMyinfoScreen.routeName);}),
              ]
            ),
            SettingsSection(
              title: '알림',
              tiles: [
                SettingsTile(title: '푸시 알림',),
              ]
            ),
            SettingsSection(
              title: '앱 정보',
              tiles: [
                SettingsTile(title: '버전 정보', subtitle: '1.0.3',),
                SettingsTile(title: '공지사항',),
                SettingsTile(title: '자주 묻는 질문',),
                SettingsTile(title: '이용약관',),
                SettingsTile(title: '오픈소스 라이선스',),
                
              ],
            ),


          ]

    );
  }
}