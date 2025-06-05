import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ServiceHttpClient {
  final String baseurl =
      'http://10.0.0.2:8000/api/'; // Replace with your actual base URL
  final secureStorage = FlutterSecureStorage();

  // POST
  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseurl$endpoint');
    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw Exception('POST Request Failed: $e');
    }
  }

  // POST WITH TOKEN
  Future<http.Response> postWithToken(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    // Buat VAR Token Yang Baca Dari Secure Storage
    final token = await secureStorage.read(key: 'token');
    final url = Uri.parse('$baseurl$endpoint');
    try {
      final response = await http.post(
        url,
        headers: {
          // Tambahkan Header Authorization dengan Token
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw Exception('POST Request With Token Failed: $e');
    }
  }

  // GET
  Future<http.Response> get(String endpoint) async {
    final token = await secureStorage.read(key: 'token');
    final url = Uri.parse('$baseurl$endpoint');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      return response;
    } catch (e) {
      throw Exception('GET Request Failed: $e');
    }
  }
}
