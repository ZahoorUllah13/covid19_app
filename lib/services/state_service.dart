import 'dart:convert';
import 'package:covid19_app/services/utilities/app_url.dart';
import 'package:http/http.dart' as http;
import '../Model/WorldStateModel.dart';

class StateServices {
  Future<WorldStateModel> fetchWorldStateRecord() async {
    final response = await http.get(Uri.parse('https://disease.sh/v3/covid-19/all'));
    print(response.statusCode);
    print(response.body);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return WorldStateModel.fromJson(data);
    } else {
      throw Exception('error');
    }
  }
  Future<List<dynamic>> WorldCountriesList() async {
    var data;
    final response = await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));
    print(response.statusCode);
    print(response.body);
    data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception('error');
    }
  }
}