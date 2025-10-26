import 'dart:convert';
import 'package:http/http.dart' as http;

class APIManager {
  static const String baseUrl = 'http://10.0.2.2:8000/api/v1';

  Future<List<dynamic>> fetchQuranChapters() async {
    final url = Uri.parse('$baseUrl/quran/chapters');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Assuming the chapters are in a 'chapters' key, otherwise return data directly
      return data['data'] ?? data;
    } else {
      throw Exception('Failed to load chapters');
    }
  }
}

