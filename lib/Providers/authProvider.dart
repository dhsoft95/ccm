import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../Models/User.dart';

class AuthProvider extends ChangeNotifier {
  final _baseUrl = dotenv.env['API_URL'];


   User? _currentUser;

  User? get currentUser => _currentUser;

  Future login({required User user}) async {
    try {
      http.Response response = await http.post(Uri.parse("$_baseUrl/login"),
          body: user.toLogin());

      if (response.statusCode == 200) {

        var output = jsonDecode(response.body);

        _currentUser = User.fromLoginJson(output['data']);
        log(_currentUser!.toJson().toString());
      }
    } catch (e) {}
  }
}
