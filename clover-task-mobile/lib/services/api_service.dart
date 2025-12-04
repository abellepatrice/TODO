import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants.dart';

class ApiService {
  static final _client = http.Client();

  static Future<Map<String, String>> _authHeaders() async {
    final session = Supabase.instance.client.auth.currentSession;
    final token = session?.accessToken;
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Future<http.Response> getTasks() async {
    final headers = await _authHeaders();
    final url = Uri.parse('$NEST_BASE_URL/tasks');
    return _client.get(url, headers: headers);
  }

  static Future<http.Response> createTask(Map<String, dynamic> body) async {
    final headers = await _authHeaders();
    final url = Uri.parse('$NEST_BASE_URL/tasks');
    return _client.post(url, headers: headers, body: jsonEncode(body));
  }

  static Future<http.Response> updateTask(String id, Map<String, dynamic> body) async {
    final headers = await _authHeaders();
    final url = Uri.parse('$NEST_BASE_URL/tasks/$id');
    return _client.put(url, headers: headers, body: jsonEncode(body));
  }

  static Future<http.Response> deleteTask(String id) async {
    final headers = await _authHeaders();
    final url = Uri.parse('$NEST_BASE_URL/tasks/$id');
    return _client.delete(url, headers: headers);
  }
}
