import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/screens/question.dart';

class ApiService {
  static const String _baseUrl =
      'https://t18q1ugo32.execute-api.us-east-1.amazonaws.com/prod';

  static Future<List<Question>> fetchQuestions(String certId) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/questions?certId=$certId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data is List) {
        return data.map((json) => Question.fromJson(json)).toList();
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception(
          'Failed to fetch questions. Status: ${response.statusCode}');
    }
  }
}