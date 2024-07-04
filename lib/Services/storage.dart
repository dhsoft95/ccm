

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Models/User.dart';

class LocalStorage {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future storeUserData({required User user}) async {
    await _storage.write(key: 'user', value: json.encode(user.toJson()));
  }

  static Future<User?> getUserData() async {
    var user = await _storage.read(key: 'user');
    var userData = User.fromJson(json.decode(user ?? '[]'));
    return userData;
  }

  static Future storeToken({required String token}) async {
    await _storage.write(key: 'token', value: token);
  }

  static Future<String?> getToken() async {
    var token = null;
    try{
       token = await _storage.read(key: 'token');
    }catch(e){
       token = null;
    }
    return token;
  }

  static Future storeProfileImage(File imageFile,
      {required String profile}) async {
    await _storage.write(key: 'profile', value: profile);
  }

  static Future<String?> getProfileImage() async {
    var profile = await _storage.read(key: 'profile');
    return profile;
  }

  static Future logout() async {
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'user');
    // await _storage.delete(key: 'profile');
  }

  static Future<bool> checkSession() async {
    bool available = false;
    try{
      available = await _storage.containsKey(key: 'token');
    }catch(e){
      available= false;
    }

    return available;
  }

  static Future storeOnboarding() async {
    await _storage.write(key: 'onboarding', value: 'true');
  }

  static Future<bool> getOnboarding() async {
    bool onboarding = false;
try{
   onboarding = await _storage.read(key: 'onboarding') != null
      ? await _storage.read(key: 'onboarding') == 'true'
      ? true
      : false
      : false;
}catch(e){
   onboarding =false;
}
    return onboarding;
  }
}

class LocalStorageProvider extends ChangeNotifier {
  User? _user;
  User? get user => _user;
  final _storage = const FlutterSecureStorage();

  Future<void> initialize() async {
    try {
      _user = await LocalStorage.getUserData();
      notifyListeners();
    } catch (e) {
      _user = null;
      notifyListeners();
    }

    notifyListeners();
  }
}
