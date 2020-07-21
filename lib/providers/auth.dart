import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:kakao_flutter_sdk/common.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class Auth with ChangeNotifier {

  final _auth = FirebaseAuth.instance;
  final _db = Firestore.instance;

  Future<FirebaseUser> kakaoLogin() async {
    try {
      print('kakao login start');
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

  Future<FirebaseUser> facebookLogin() async {
    try {
      final FacebookLogin facebookSignIn = FacebookLogin();
      final FacebookLoginResult result = await facebookSignIn.logIn(['email', 'public_profile']);
      FacebookAccessToken accessToken;

      switch(result.status) {
        case FacebookLoginStatus.loggedIn:
          accessToken = result.accessToken;
          break;
        case FacebookLoginStatus.cancelledByUser:
          break;
        case FacebookLoginStatus.error:
          break;
      }
      
      AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: accessToken.token);
      AuthResult authResult = await _auth.signInWithCredential(credential);

      print(authResult.user.displayName);
      print(authResult.user);

      await _db.collection('users').document(authResult.user.uid).setData({
        'displayName': authResult.user.displayName,
        'email': authResult.user.email,
        'provider': 'FACEBOOK',
        'thumbnail': authResult.user.photoUrl,
        'honey': 0,
        'rank': -1,
        'works': []
      });
  
      return authResult.user;
    } on PlatformException catch(error){
      var message = 'An error occurred, please check your credentials!';
      print(error);
    } catch(error) {
      print(error);
    }
  }

  Future<User> getUserFromDB() async {
    final firebaseUser = await _auth.currentUser();
    if(firebaseUser == null || firebaseUser.uid == null) {
      return null;
    }
    final userData = await _db.collection('users').document(firebaseUser.uid).get();
    User user = User(userData.data['uid'], userData.data['displayName'], userData.data['email'], 
        userData.data['provider'], userData.data['thumbnail'], userData.data['honey'],
        userData.data['rank'], userData.data['works']);

    return user;
  }



  Future<String> getFirebaseToken(String kakaoToken) async {
    print('kakaoToken: $kakaoToken');
    const url = "https://asia-northeast1-honeytoon-server.cloudfunctions.net/app/custom-token";
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
    final authResult = await _auth.signInWithCustomToken(token: token);
    print(authResult.user);
    return authResult.user;
  }
}

