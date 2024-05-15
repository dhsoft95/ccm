import 'dart:convert';
import 'dart:developer';

import 'package:ccm/Models/supporter.dart';
import 'package:ccm/Services/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class SupporterProvider extends ChangeNotifier {
  bool _messageSent = false;
  bool get messageSent =>_messageSent;
  bool _supporterAdded = false;
  bool get supporterAdded => _supporterAdded;
  final _baseUrl = dotenv.env['API_URL'];

  Future addSupporter({required Supporter supporter}) async {
    String? token = await LocalStorage.getToken();
    try {
      http.Response response = await http.post(Uri.parse("$_baseUrl/supporters"),
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
          body: supporter.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        var output = jsonDecode(response.body);
        _supporterAdded = true;
        notifyListeners();

        log(output.toString());
      } else {
        print(response.body);
        _supporterAdded = false;
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
      _supporterAdded = false;
      notifyListeners();
    }
  }

  Future sendMessage({required String message}) async {
    String? token = await LocalStorage.getToken();
    try {
      http.Response response = await http
          .post(Uri.parse("$_baseUrl/send-sms-invitation"), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      }, body: {
        "message": message
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        var output = jsonDecode(response.body);
_messageSent=true;
        notifyListeners();

        log(output.toString());
      } else {
        print(response.body);
        _messageSent=false;
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
      _messageSent=false;
      notifyListeners();
    }
  }
}
