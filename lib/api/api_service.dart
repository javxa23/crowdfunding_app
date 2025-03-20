import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = "http://localhost:8081";

  static Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {"email": email, "password": password},
    );

    if (response.statusCode == 200) {
      final token = response.body;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      return token;
    } else {
      return null;
    }
  }

  static Future<bool> register(
    String username,
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      body: {"username": username, "email": email, "password": password},
    );

    return response.statusCode == 201;
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  static Future<String?> fetchProtectedData() async {
    String? token = await getToken();
    if (token == null) return null;

    final response = await http.get(
      Uri.parse('$baseUrl/protected'),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }
}
