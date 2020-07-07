import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:kakao_flutter_sdk/common.dart';

class Auth with ChangeNotifier {
  void kakaoLogin() async {
    try {
      final installed = await isKakaoTalkInstalled();
      final authCode = installed ? await AuthCodeClient.instance.requestWithTalk() : await AuthCodeClient.instance.request();
      print('authCode:$authCode');
      final token = await AuthApi.instance.issueAccessToken(authCode);
      
      print('token=$token');
      AccessTokenStore.instance.toStore(token);
    } on KakaoAuthException catch(error) {
      print(error);
    } on KakaoClientException catch (error) {
      print(error);
    } catch(error){
      print(error);
    }
  }
}

