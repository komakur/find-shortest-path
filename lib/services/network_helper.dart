import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webspark_test_project/models/field.dart';

// class for making requests to API
class NetworkHelper {
  //GET data from API uri
  static Future<List<Field>> getAllFields(String url) async {
    http.Response response =
        await http.get(Uri.parse(url), headers: {'accept': 'application/json'});
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final data = List<Map<String, dynamic>>.from(json['data']);
      return data.map((e) => Field.fromJson(e)).toList();
    } else {
      throw Exception('${response.statusCode}');
    }
  }

  //POST data to API
  static sendAllSolutions(List<Field> fields) async {
    final body = fields.map((e) => e.toJson()).toList();
    final response = await http.post(
      Uri.parse('https://flutter.webspark.dev/flutter/api'),
      body: jsonEncode(body),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
    } else {
      throw Exception('${response.statusCode}');
    }
  }
}
