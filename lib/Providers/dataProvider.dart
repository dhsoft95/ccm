import 'dart:convert';
import 'dart:developer';

import 'package:ccm/Models/locations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class DataProvider extends ChangeNotifier {
  final _baseUrl = dotenv.env['API_URL'];

  List<Region>? _regions;
  List<Region>? get regions => _regions;

  Future<void> getDropdownData() async {
    try {
      http.Response response = await http
          .get(Uri.parse("$_baseUrl/dropdown-data"), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      });

      if (response.statusCode == 200) {
        var output = jsonDecode(response.body);
        List temp = output['regions'];

        _regions = temp.map((region) => Region.fromJson(region)).toList();
        log(temp.toString());
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
