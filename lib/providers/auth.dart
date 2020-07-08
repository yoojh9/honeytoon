import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:kakao_flutter_sdk/common.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {

  Future<FirebaseUser> kakaoLogin() async {
    try {
      final installed = await isKakaoTalkInstalled();
      final authCode = installed ? await AuthCodeClient.instance.requestWithTalk() : await AuthCodeClient.instance.request();
      final token = await AuthApi.instance.issueAccessToken(authCode);
    
      print('accessToken:${token.accessToken}');

      final firebaseToken = await getFirebaseToken(token.accessToken);
      final firebaseUser = await signInWithCustomToken(firebaseToken);

      return firebaseUser;

    } on KakaoAuthException catch(error) {
      print(error);
    } on KakaoClientException catch (error) {
      print(error);
    } catch(error){
      print(error);
    }
  }

  Future<String> getFirebaseToken(String kakaoToken) async {
    print('kakaoToken: $kakaoToken');
    const url = "https://asia-northeast1-honey-toon.cloudfunctions.net/app/custom-token";
    final response = await http.post(
      url, 
      headers: {"Content-Type": "application/json"}, 
      body: json.encode({"token": kakaoToken})
    );
    final data = json.decode(response.body) as Map<String, dynamic>;
    print('data=$data');
    return data['firebase_token'];
  }

  Future<FirebaseUser> signInWithCustomToken(String token) async {
    final authResult = await FirebaseAuth.instance.signInWithCustomToken(token: token);
    print(authResult.user);
    return authResult.user;
  }
}

