import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api.dart';
import '../models/auth_response.dart';
import '../utils/token_storage.dart';

class AuthService {
  static Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("${Api.baseUrl}/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final auth = AuthResponse.fromJson(data);

      await TokenStorage.saveAuth(auth.token, auth.user);
      return true;
    }
    return false;
  }

  static Future<bool> register(
    String name,
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("${Api.baseUrl}/register"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({"name": name, "email": email, "password": password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    }
    print(response.statusCode);
    print(response.body);

    return false;
  }
}
