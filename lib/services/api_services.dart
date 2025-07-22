import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/screens/question.dart';
import '../models/screens/mock_data.dart';

class ApiService {
  static const String _baseUrl =
      'https://t18q1ugo32.execute-api.us-east-1.amazonaws.com/prod';

  static Future<List<Question>> fetchQuestions(String certId) async {
    try {
      print('🔗 Connecting to AWS Lambda backend...');
      print('📍 Region: us-east-1');
      print('🎯 CertId: $certId');
      final url = '$_baseUrl/questions?certId=$certId';
      print('🌐 API Gateway URL: $url');
      
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Access-Control-Allow-Origin': '*',
        },
      ).timeout(const Duration(seconds: 30));

      print('Response status: ${response.statusCode}');
      print('Response headers: ${response.headers}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List) {
          if (data.isEmpty) {
            print('Warning: API returned empty list');
            return [];
          }
          return data.map((json) => Question.fromJson(json)).toList();
        } else {
          throw Exception('Unexpected response format: Expected List, got ${data.runtimeType}');
        }
      } else if (response.statusCode == 404) {
        throw Exception('API endpoint not found. Check if the Lambda function is deployed correctly.');
      } else if (response.statusCode == 403) {
        throw Exception('API access forbidden. Check CORS settings and API key configuration.');
      } else if (response.statusCode >= 500) {
        throw Exception('Server error (${response.statusCode}). The backend service may be down.');
      } else {
        throw Exception('Failed to fetch questions. Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print('API Error: $e');
      print('Falling back to mock data...');
      
      // Return mock data as fallback
      return MockData.getSampleQuestions();
    }
  }

  // Add a test method to verify API connectivity
  static Future<bool> testConnection() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 10));
      
      print('Connection test - Status: ${response.statusCode}');
      return response.statusCode < 500;
    } catch (e) {
      print('Connection test failed: $e');
      return false;
    }
  }
}