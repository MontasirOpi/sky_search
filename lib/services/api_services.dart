import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sky_search/models/airport_model.dart';

class AirportService {
  static const String apiUrl =
      'https://enterpise.s3.ap-southeast-1.amazonaws.com/resources/airport.json';

  static Future<List<Airport>> fetchAirports() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Airport.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load airports');
      }
    } catch (e) {
      throw Exception('Error fetching airports: $e');
    }
  }
}
