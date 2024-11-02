import 'dart:convert';
import 'package:http/http.dart' as http;
import 'place.dart';

class ApiService {
  static Future<List<Place>> fetchPlaces() async {
    final response = await http.get(Uri.parse('http://localhost:8080/api/places'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((place) => Place.fromJson(place)).toList();
    } else {
      throw Exception('Failed to load places');
    }
  }
}
