import 'dart:convert';

import 'package:covidtracker/pojos/Covid_Countries.dart';
import 'package:http/http.dart' as http;

class Services {
  static const String countryURL =
      'https://corona.lmao.ninja/v2/countries?sort=cases';

  static Future<List<Covid_Countries>> getCovidCountries() async {
    try {
      final response = await http.get(countryURL);
      if (response.statusCode == 200) {
        List<Covid_Countries> covidCountriesList = parse(response.body);
        return covidCountriesList;
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  

  static List<Covid_Countries> parse(String body) {

    final parsed = json.decode(body);

    return parsed.map<Covid_Countries> ( 
      (json) => Covid_Countries.fromJson(json)).toList();
  }
}
