import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:ccm/Models/supporter.dart';
import 'package:ccm/Services/storage.dart';

class SupporterProvider extends ChangeNotifier {
  bool _messageSent = false;
  bool get messageSent => _messageSent;
  bool _supporterAdded = false;
  bool get supporterAdded => _supporterAdded;
  final _baseUrl = dotenv.env['API_URL'];

  List<Supporter> _supporters = [];
  List<Supporter> get supporters => _supporters;

  Future<void> getSupporterData() async {
    String? token = await LocalStorage.getToken();
    try {
      http.Response response = await http.get(
        Uri.parse("$_baseUrl/all-supporters"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        var output = jsonDecode(response.body);
        List temp = output;
        _supporters =
            temp.map((supporter) => Supporter.fromJson(supporter)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load supporters');
      }
    } catch (e) {
      print(e.toString());
    }

  }

  Future<void> addSupporter({required Supporter supporter}) async {
    String? token = await LocalStorage.getToken();
    try {
      http.Response response = await http.post(
        Uri.parse("$_baseUrl/supporters"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: supporter.toJson(),
      );

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

  Future<void> sendMessage({required String message}) async {
    String? token = await LocalStorage.getToken();
    try {
      http.Response response = await http.post(
        Uri.parse("$_baseUrl/send-sms-invitation"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: {"sms_content": message},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var output = jsonDecode(response.body);
        _messageSent = true;
        notifyListeners();
        log(output.toString());
      } else {
        print(response.body);
        _messageSent = false;
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
      _messageSent = false;
      notifyListeners();
    }
  }
}
