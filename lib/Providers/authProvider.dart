import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../Models/User.dart';
import '../Services/storage.dart';

class AuthProvider extends ChangeNotifier {
  final String? _baseUrl = dotenv.env['API_URL'];

  User? _registerUser;
  String? _otpVerifier;
  User? _currentUser;
  bool _profileUpdated = false;
  bool _otpSent = false;

  // Getters
  String? get otpVerifier => _otpVerifier;
  User? get registerUser => _registerUser;
  User? get currentUser => _currentUser;
  bool get profileUpdated => _profileUpdated;
  bool get otpSent => _otpSent;

  // Setters
  set registerUser(User? value) {
    _registerUser = value;
    notifyListeners();
  }

  set profileUpdated(bool value) {
    _profileUpdated = value;
    notifyListeners();
  }

  // Login Function
  Future<String?> login({required User user}) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/login"),
        body: user.toLogin(),
      );

      final responseData = jsonDecode(response.body);

      switch (response.statusCode) {
        case 200:
          _currentUser = User.fromAuthJson(responseData['data']);
          await _storeUserData();
          notifyListeners();
          return null;
        case 401:
          return "Invalid email or password.";
        default:
          return "Login failed: ${responseData['message'] ?? 'Unknown error'}";
      }
    } catch (e) {
      debugPrint("Login error: $e");
      return "Connection error. Please check your internet connection.";
    }
  }

  // Registration Function
  Future<Map<String, dynamic>> register() async {
    try {
      if (_registerUser == null) {
        return {'success': false, 'message': 'Registration data is missing'};
      }

      final response = await http.post(
        Uri.parse("$_baseUrl/register"),
        body: _registerUser!.toRegistration(),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _currentUser = User.fromAuthJson(responseData['data']);
        await _storeUserData();
        notifyListeners();
        return {'success': true, 'message': 'Registration successful'};
      } else {
        debugPrint('Registration failed: ${response.body}');
        return {'success': false, 'message': responseData['message'] ?? 'Registration failed'};
      }
    } catch (e) {
      debugPrint('Registration error: $e');
      return {'success': false, 'message': 'Connection error. Please try again.'};
    }
  }

  // Profile Update Function
  Future<Map<String, dynamic>> updateProfile({required User userData}) async {
    try {
      final result = await Future.wait([
        LocalStorage.getUserData(),
        LocalStorage.getToken(),
      ]);

      final String? token = result[1] as String?;

      if (token == null) {
        return {'success': false, 'message': 'Authentication token missing'};
      }

      final response = await http.put(
        Uri.parse("$_baseUrl/candidate-update"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
        body: userData.toUpdateProfile(),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _currentUser = User.fromAuthJson(responseData['data']);
        await LocalStorage.storeUserData(user: _currentUser!);
        _profileUpdated = true;
        notifyListeners();
        return {'success': true, 'message': 'Profile updated successfully'};
      } else {
        _profileUpdated = false;
        notifyListeners();
        return {'success': false, 'message': responseData['message'] ?? 'Profile update failed'};
      }
    } catch (e) {
      debugPrint('Profile update error: $e');
      _profileUpdated = false;
      notifyListeners();
      return {'success': false, 'message': 'Connection error. Please try again.'};
    }
  }

  // Send OTP Function
  Future<Map<String, dynamic>> sendOtp({required String phone}) async {
    try {
      if (phone.isEmpty) {
        return {'success': false, 'message': 'Phone number is required'};
      }

      final formattedPhone = phone.startsWith('+') ? phone.substring(1) : phone;

      final response = await http.post(
        Uri.parse("$_baseUrl/send-otp"),
        body: {"phone": formattedPhone},
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _otpVerifier = responseData['otp']?.toString();
        _otpSent = true;
        notifyListeners();
        log('OTP Response: $responseData');
        return {'success': true, 'message': 'OTP sent successfully'};
      } else {
        _otpSent = false;
        notifyListeners();
        return {'success': false, 'message': responseData['message'] ?? 'Failed to send OTP'};
      }
    } catch (e) {
      debugPrint('Send OTP error: $e');
      _otpSent = false;
      notifyListeners();
      return {'success': false, 'message': 'Connection error. Please try again.'};
    }
  }

  // Verify OTP Function
  Future<Map<String, dynamic>> verifyOtp({required String otp}) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl/verify-otp"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'otp': otp}),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // OTP verification successful
        notifyListeners();
        return {
          'success': true,
          'message': responseData['message'] ?? 'OTP verification successful.'
        };
      } else if (response.statusCode == 401) {
        // OTP expired or incorrect
        return {
          'success': false,
          'message': responseData['message'] ?? 'Incorrect OTP or OTP expired.'
        };
      } else {
        // Handle other errors
        return {
          'success': false,
          'message': 'OTP verification failed. Please try again.'
        };
      }
    } catch (e) {
      debugPrint('OTP verification error: $e');
      return {
        'success': false,
        'message': 'Connection error. Please try again.'
      };
    }
  }


  // Store User Data Function
  Future<void> _storeUserData() async {
    if (_currentUser != null) {
      await LocalStorage.storeToken(token: _currentUser!.token.toString());
      await LocalStorage.storeUserData(user: _currentUser!);
    }
  }

  // Logout Function
  void logout() {
    _currentUser = null;
    _registerUser = null;
    _otpVerifier = null;
    _otpSent = false;
    _profileUpdated = false;
    notifyListeners();
  }
}
