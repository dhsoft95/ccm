import 'dart:convert';
import 'dart:developer';

import 'package:ccm/Models/locations.dart';
import 'package:ccm/Models/messages.dart';
import 'package:ccm/Models/positions.dart';
import 'package:ccm/Services/storage.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class DataProvider extends ChangeNotifier {
  final _baseUrl = dotenv.env['API_URL'];




  List<Region> _regions = [];
  List<Region> get regions => _regions;
  List<Positions> _positions = [];
  List<Positions> get positions => _positions;

  Future<void> getRegionData() async {
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
        notifyListeners();
      }else{
        _regions=[];
        notifyListeners();
      }
    } catch (e) {
      _regions=[];
      notifyListeners();
      print(e.toString());
    }
  }

  Future<void> getPositionsData() async {
    try {
      http.Response response = await http
          .get(Uri.parse("$_baseUrl/positions-data"), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      });

      if (response.statusCode == 200) {
        var output = jsonDecode(response.body);
        List temp = output['positions'];

        _positions =
            temp.map((position) => Positions.fromJson(position)).toList();
        notifyListeners();
      }else{
        _positions=[];
        notifyListeners();
      }
    } catch (e) {
      _positions=[];
      notifyListeners();
      print(e.toString());
    }
  }



}
