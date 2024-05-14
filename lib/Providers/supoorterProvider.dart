import 'dart:convert';
import 'dart:developer';

import 'package:ccm/Models/supporter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class SupporterProvider extends ChangeNotifier {
  final _baseUrl = dotenv.env['API_URL'];

  Future register({required Supporter supporter}) async {
    try {
      http.Response response = await http.post(Uri.parse("$_baseUrl/create"),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer token"
          },
          body: supporter.toJson());

      if (response.statusCode == 200||response.statusCode == 201) {
        var output = jsonDecode(response.body);

        log(output);
      }
    } catch (e) {}
  }
}
