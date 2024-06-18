import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../Models/supporter.dart';
import '../Services/storage.dart';
import '../Models/messages.dart';

class SupporterProvider with ChangeNotifier {
  bool _messageSent = false;
  bool get messageSent => _messageSent;

  bool _supporterAdded = false;
  bool get supporterAdded => _supporterAdded;
  set supporterAdded(bool value) {
    _supporterAdded = value;
    notifyListeners();
  }

  Messages? _messagesCount;
  Messages? get messagesCount => _messagesCount;

  List<Messages> _messages = [];
  List<Messages> get messages => _messages;

  final _baseUrl = dotenv.env['API_URL'];

  List<Supporter> _supporters = [];
  List<Supporter> get supporters => _supporters;
  set supporters(List<Supporter> value) {
    _supporters = value;
    notifyListeners();
  }

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

  Future<String> addSupporter({required Supporter supporter}) async {
    log(supporter.toJson().toString());
    String? token = await LocalStorage.getToken();
    String message = 'An error occurred';
    try {
      http.Response response = await http.post(
        Uri.parse("$_baseUrl/supporters"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: supporter.toJson(),
      );

      log(response.statusCode.toString());
      log(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var output = jsonDecode(response.body);
    try{
      if (output.containsKey('message')) {
        message = output['message'];
      } else {
        // In case 'message' key is missing, default success message
        message = 'Supporter added successfully';
      }
    }catch(e){
      print(e.toString());
    }
        _supporterAdded = true;
        notifyListeners();
      } else {
        var output = jsonDecode(response.body);
        if (output.containsKey('message')) {
          message = output['message'];
        } else {
          // In case 'message' key is missing, default error message
          message = 'Failed to add supporter';
        }
        _supporterAdded = false;
        notifyListeners();
      }
    } catch (e,stackTrace) {
      log(stackTrace.toString());
      print(e.toString());
      _supporterAdded = false;
      message = 'Failed to add supporter';
      notifyListeners();
    }
    return message;
  }

  Future<String?> sendMessage({required String message}) async {
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
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        if (jsonResponse.isNotEmpty) {
          return jsonResponse[0]['message'] ?? 'Unknown message';
        }
      }
      return 'Unknown message';
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> getMessages() async {
    String? token = await LocalStorage.getToken();
    try {
      http.Response response =
      await http.get(Uri.parse("$_baseUrl/recent-transactions"), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      });

      if (response.statusCode == 200) {
        var output = jsonDecode(response.body);
        List temp = output;

        _messages =
            temp.map((position) => Messages.fromJson(position)).toList();
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getMessagesCount() async {
    String? token = await LocalStorage.getToken();
    try {
      http.Response response =
      await http.get(Uri.parse("$_baseUrl/count-messages"), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      });
      if (response.statusCode == 200) {
        var output = jsonDecode(response.body);
        _messagesCount = Messages.fromMessageCount(output);
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteSupporter(int supporterId, BuildContext context) async {
    String? token = await LocalStorage.getToken();
    try {
      http.Response response = await http.delete(
        Uri.parse("$_baseUrl/supporters/$supporterId"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        print('Supporter deleted successfully');
        // _supporters.removeWhere((element) => element.id.toString()==supporterId.toString());
        // notifyListeners();


        // Refresh supporter data after deletion
        await getSupporterData();
      } else if (response.statusCode == 401) {
        throw Exception('Unauthenticated');
      } else if (response.statusCode == 403) {
        throw Exception('Unauthorized');
      } else if (response.statusCode == 404) {
        throw Exception('Supporter not found');
      } else {
        throw Exception('Failed to delete supporter');
      }
    } catch (e) {
      print('Failed to delete supporter: ${e.toString()}');
      throw Exception('Failed to delete supporter');
    }
  }

// Additional methods as needed...

}
