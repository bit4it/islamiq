
import 'package:dio/dio.dart';

class APIService {
  // Add your API methods here
  final String baseUrl = 'http://192.168.1.5:8000/api/v1';
  final Dio _dio = Dio();
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<Response> get(String endpoint) async {
    try {
      print('Making GET request to: $baseUrl/$endpoint');
      final response = await _dio.get('$baseUrl/$endpoint', options: Options(headers: headers));
      print('GET Response status: ${response.statusCode}');
      return response;
    } catch (e) {
      print('GET Error: $e');
      print('Full URL: $baseUrl/$endpoint');
      rethrow;
    }
  }

  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    try {
      print('Making POST request to: $baseUrl/$endpoint');
      final response = await _dio.post('$baseUrl/$endpoint', data: data, options: Options(headers: headers));
      print('POST Response status: ${response.statusCode}');
      return response;
    } catch (e) {
      print('POST Error: $e');
      print('Full URL: $baseUrl/$endpoint');
      rethrow;
    }
  }

  // Test connectivity to your server
  Future<bool> testConnection() async {
    try {
      print('Testing connection to: $baseUrl');
      _dio.options.connectTimeout = Duration(seconds: 5);
      _dio.options.receiveTimeout = Duration(seconds: 5);
      final response = await _dio.get(baseUrl, options: Options(headers: headers));
      print('Connection test successful: ${response.statusCode}');
      return true;
    } catch (e) {
      print('Connection test failed: $e');
      return false;
    }
  }
}

