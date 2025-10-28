import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sky_search/models/airport_model.dart';

class AirportService {
  static const String apiUrl =
      'https://enterpise.s3.ap-southeast-1.amazonaws.com/resources/airport.json';

  static Future<List<Airport>> fetchAirports() async {
    try {
      developer.log('🛫 Fetching airports from: $apiUrl');

      final response = await http
          .get(Uri.parse(apiUrl), headers: {'Accept': 'application/json'})
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw Exception(
                'Connection timeout - please check your internet',
              );
            },
          );

      developer.log('Response Status: ${response.statusCode}');
      developer.log('Response Body Length: ${response.body.length} bytes');

      if (response.statusCode == 200) {
        try {
          final List<dynamic> data = json.decode(response.body);
          developer.log('Successfully parsed ${data.length} airports');

          if (data.isEmpty) {
            developer.log('Warning: API returned empty array');
            return [];
          }

          // Log first airport for debugging
          if (data.isNotEmpty) {
            developer.log('First airport sample: ${data[0]}');
          }

          final airports = data.map((json) {
            try {
              return Airport.fromJson(json as Map<String, dynamic>);
            } catch (e) {
              developer.log('Error parsing airport: $json - Error: $e');
              rethrow;
            }
          }).toList();

          developer.log('🎉 Successfully loaded ${airports.length} airports');
          return airports;
        } catch (e, stackTrace) {
          developer.log('JSON Parse Error: $e');
          developer.log('Stack: $stackTrace');
          throw Exception('Failed to parse airport data: $e');
        }
      } else {
        developer.log(' HTTP Error: ${response.statusCode}');
        developer.log('Response body: ${response.body}');
        throw Exception('Server returned ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      developer.log('Fatal Error in fetchAirports: $e');
      developer.log('Stack trace: $stackTrace');
      rethrow;
    }
  }
}
