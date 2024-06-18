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

  bool _profileUpdated = false;

  bool get profileUpdated => _profileUpdated;

  set profileUpdated(bool value) {
    _profileUpdated = value;
  }

  bool _otpSent = false;
  bool get otpSent => _otpSent;

  Future<String?> login({required User user}) async {
    try {
      http.Response response =
          await http.post(Uri.parse("$_baseUrl/login"), body: user.toLogin());

      if (response.statusCode == 200) {
        var output = jsonDecode(response.body);

        _currentUser = User.fromAuthJson(output['data']);
        await LocalStorage.storeToken(token: _currentUser!.token.toString());
        await LocalStorage.storeUserData(user: _currentUser!);
        notifyListeners();
        return null; // No error, login successful
      } else {
        // Handle different HTTP error status codes
        if (response.statusCode == 401) {
          // Unauthorized: Invalid credentials
          return "Invalid email or password.";
        } else {
          // Other errors
          return "Login failed with status code ${response.statusCode}";
        }
      }
    } catch (e) {
      print("Error during login: $e");
      return "An error occurred during login.";
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

  Future updateProfile({required User userData}) async {
    final result = await Future.wait([
      LocalStorage.getUserData(),
      LocalStorage.getToken(),
    ]);
    User? user = result[0] as User?;
    String? token = result[1] as String?;
    try {
      http.Response response = await http.put(
          Uri.parse(
            "$_baseUrl/candidate-update",
          ),
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
          body: userData.toUpdateProfile());

      if (response.statusCode == 200) {
        var output = jsonDecode(response.body);

        _currentUser = User.fromAuthJson(output['data']);
        await LocalStorage.storeUserData(user: _currentUser!);
        _profileUpdated = true;
        notifyListeners();
      } else {
        if (kDebugMode) {
          print(response.statusCode.toString());
          print(response.body);
        }

        _profileUpdated = false;
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      _profileUpdated = false;
      notifyListeners();
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
