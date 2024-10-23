import 'dart:convert';
import 'dart:developer' as dev;
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
    dev.log('=== getSupporterData Started ===');
    String? token = await LocalStorage.getToken();
    dev.log('Token available: ${token != null}');

    try {
      dev.log('Making GET request to: $_baseUrl/all-supporters');

      final response = await http.get(
        Uri.parse("$_baseUrl/all-supporters"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      dev.log('Response status code: ${response.statusCode}');
      dev.log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        dev.log('Successful response received');
        var output = jsonDecode(response.body);
        dev.log('Decoded JSON: $output');
        List temp = output;
        _supporters = temp.map((supporter) => Supporter.fromJson(supporter)).toList();
        dev.log('Parsed ${_supporters.length} supporters');
        notifyListeners();
      } else {
        dev.log('Error response received');
        throw Exception('Failed to load supporters');
      }
    } catch (e, stackTrace) {
      dev.log('Error in getSupporterData: $e');
      dev.log('Stack trace: $stackTrace');
      rethrow;
    } finally {
      dev.log('=== getSupporterData Completed ===');
    }
  }

  Future<String> addSupporter({required Supporter supporter}) async {
    dev.log('=== addSupporter Started ===');
    dev.log('Supporter data to add: ${supporter.toJson()}');
    String? token = await LocalStorage.getToken();
    String message = 'An error occurred';

    try {
      dev.log('Making POST request to: $_baseUrl/supporters');
      dev.log('Request headers: Accept: application/json, Authorization: Bearer token');
      dev.log('Request body: ${supporter.toJson()}');

      http.Response response = await http.post(
        Uri.parse("$_baseUrl/supporters"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: supporter.toJson(),
      );

      dev.log('Response status code: ${response.statusCode}');
      dev.log('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        dev.log('Successful response received');
        var output = jsonDecode(response.body);
        dev.log('Decoded response: $output');

        try {
          message = output['message'] ?? 'Supporter added successfully';
          dev.log('Success message: $message');
          _supporterAdded = true;
        } catch (e) {
          dev.log('Error parsing success message: $e');
          message = 'Supporter added successfully';
        }
        notifyListeners();
      } else {
        dev.log('Error response received');
        var output = jsonDecode(response.body);
        message = output['message'] ?? 'Failed to add supporter';
        dev.log('Error message: $message');
        _supporterAdded = false;
        notifyListeners();
      }
    } catch (e, stackTrace) {
      dev.log('Error in addSupporter: $e');
      dev.log('Stack trace: $stackTrace');
      _supporterAdded = false;
      message = 'Failed to add supporter';
      notifyListeners();
    } finally {
      dev.log('=== addSupporter Completed ===');
    }
    return message;
  }

  Future<Map<String, dynamic>> sendMessage({required String message}) async {
    dev.log('=== sendMessage Started ===');
    dev.log('Message content: $message');
    String? token = await LocalStorage.getToken();

    try {
      dev.log('Making POST request to: $_baseUrl/send-sms-invitation');
      dev.log('Request body: {"sms_content": "$message"}');

      http.Response response = await http.post(
        Uri.parse("$_baseUrl/send-sms-invitation"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: {"sms_content": message},
      );

      dev.log('Response status code: ${response.statusCode}');
      dev.log('Response body: ${response.body}');

      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        dev.log('Message sent successfully');
        return {'error': false, 'message': jsonResponse['message']};
      } else {
        dev.log('Failed to send message');
        return {'error': true, 'message': jsonResponse['message'] ?? 'Unknown error occurred'};
      }
    } catch (e, stackTrace) {
      dev.log('Error in sendMessage: $e');
      dev.log('Stack trace: $stackTrace');
      return {'error': true, 'message': 'Failed to send message. Please try again.'};
    } finally {
      dev.log('=== sendMessage Completed ===');
    }
  }

  Future<void> getMessages() async {
    dev.log('=== getMessages Started ===');
    String? token = await LocalStorage.getToken();

    try {
      dev.log('Making GET request to: $_baseUrl/recent-transactions');

      http.Response response = await http.get(
        Uri.parse("$_baseUrl/recent-transactions"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      dev.log('Response status code: ${response.statusCode}');
      dev.log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        dev.log('Successful response received');
        var output = jsonDecode(response.body);
        List temp = output;
        _messages = temp.map((message) => Messages.fromJson(message)).toList();
        dev.log('Parsed ${_messages.length} messages');
        notifyListeners();
      } else {
        dev.log('Error response received');
        throw Exception('Failed to fetch messages');
      }
    } catch (e, stackTrace) {
      dev.log('Error in getMessages: $e');
      dev.log('Stack trace: $stackTrace');
      rethrow;
    } finally {
      dev.log('=== getMessages Completed ===');
    }
  }

  Future<void> getMessagesCount() async {
    dev.log('=== getMessagesCount Started ===');
    String? token = await LocalStorage.getToken();

    try {
      dev.log('Making GET request to: $_baseUrl/count-messages');

      http.Response response = await http.get(
        Uri.parse("$_baseUrl/count-messages"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      dev.log('Response status code: ${response.statusCode}');
      dev.log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        dev.log('Successful response received');
        var output = jsonDecode(response.body);
        _messagesCount = Messages.fromMessageCount(output);
        dev.log('Successfully parsed message count');
        notifyListeners();
      } else {
        dev.log('Error response received');
        throw Exception('Failed to fetch message count');
      }
    } catch (e, stackTrace) {
      dev.log('Error in getMessagesCount: $e');
      dev.log('Stack trace: $stackTrace');
      rethrow;
    } finally {
      dev.log('=== getMessagesCount Completed ===');
    }
  }

  Future<bool> deleteSupporter(int supporterId, BuildContext context) async {
    dev.log('=== deleteSupporter Started ===');
    dev.log('Supporter ID to delete: $supporterId');
    String? token = await LocalStorage.getToken();

    try {
      dev.log('Making DELETE request to: $_baseUrl/supporters/$supporterId');

      http.Response response = await http.delete(
        Uri.parse("$_baseUrl/supporters/$supporterId"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      dev.log('Response status code: ${response.statusCode}');
      dev.log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        dev.log('Supporter deleted successfully');
        _supporters.removeWhere((supporter) => supporter.id == supporterId);
        notifyListeners();
        return true;
      } else {
        dev.log('Failed to delete supporter');
        return false;
      }
    } catch (e, stackTrace) {
      dev.log('Error in deleteSupporter: $e');
      dev.log('Stack trace: $stackTrace');
      return false;
    } finally {
      dev.log('=== deleteSupporter Completed ===');
    }
  }
}