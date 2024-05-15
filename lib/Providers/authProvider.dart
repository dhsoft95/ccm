import 'dart:convert';
import 'dart:developer';

import 'package:ccm/Services/storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../Models/User.dart';

class AuthProvider extends ChangeNotifier {
  final _baseUrl = dotenv.env['API_URL'];

  User? _registerUser;
  String? _otpVerifier;
  String? get otpVerifier => _otpVerifier;

  set registerUser(User? value) {
    _registerUser = value;
  }

  User? get registerUser => _registerUser;

  User? _currentUser;

  User? get currentUser => _currentUser;

  bool _otpSent = false;
  bool get otpSent => _otpSent;

  Future login({required User user}) async {
    try {
      http.Response response =
          await http.post(Uri.parse("$_baseUrl/login"), body: user.toLogin());

      if (response.statusCode == 200) {
        var output = jsonDecode(response.body);

        _currentUser = User.fromAuthJson(output['data']);
        await LocalStorage.storeToken(token: _currentUser!.token.toString());
        await LocalStorage.storeUserData(user: _currentUser!);
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future register() async {
    try {
      http.Response response = await http.post(Uri.parse("$_baseUrl/register"),
          body: _registerUser!.toRegistration());

      if (response.statusCode == 200) {
        var output = jsonDecode(response.body);
        print(output.toString());

        _currentUser = User.fromAuthJson(output['data']);
        await LocalStorage.storeToken(token: _currentUser!.token.toString());
        await LocalStorage.storeUserData(user: _currentUser!);
        notifyListeners();
      } else {
        print(response.statusCode.toString());
        print(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future sendOtp({required String phone}) async {
    try {
      http.Response response = await http.post(Uri.parse("$_baseUrl/sendOtp"),
          body: {"phone": phone.split('+')[1]});

      if (response.statusCode == 200) {
        var output = jsonDecode(response.body);
        _otpVerifier = output['\ otp'].toString();
        _otpSent = true;
        notifyListeners();
        log(output.toString());
      } else {
        _otpSent = false;
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
      _otpSent = false;
      notifyListeners();
    }
  }
}
