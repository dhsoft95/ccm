import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../Models/User.dart';

class AuthProvider extends ChangeNotifier {
  final _baseUrl = dotenv.env['API_URL'];

  Future login({required User user}) async {
    try {
      http.Response response = await http.post(Uri.parse("$_baseUrl/login"),
          body: json.encode(user.toLogin()));

      log("$_baseUrl/login");
      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        log(response.body);
      }
    } catch (e) {}
  }
}
