import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api.dart';
import '../models/todo.dart';
import '../utils/token_storage.dart';

class TodoService {
  static Future<List<Todo>> getTodos() async {
    final token = await TokenStorage.getToken();

    final response = await http.get(
      Uri.parse("${Api.baseUrl}/todos"),
      headers: {"Authorization": "Bearer $token", "Accept": "application/json"},
    );

    final List data = jsonDecode(response.body);
    return data.map((e) => Todo.fromJson(e)).toList();
  }

  static Future<bool> addTodo({
    required String title,
    String? description,
  }) async {
    final token = await TokenStorage.getToken();

    final response = await http.post(
      Uri.parse("${Api.baseUrl}/todos"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({"title": title, "description": description}),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }

  static Future<bool> updateTodo({
    required int id,
    required String title,
    String? description,
  }) async {
    final token = await TokenStorage.getToken();

    final response = await http.put(
      Uri.parse("${Api.baseUrl}/todos/$id"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({"title": title, "description": description}),
    );

    return response.statusCode == 200;
  }

  static Future<bool> toggleComplete(int id, bool value) async {
    final token = await TokenStorage.getToken();

    final response = await http.patch(
      Uri.parse("${Api.baseUrl}/todos/$id"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({"is_completed": value}),
    );

    return response.statusCode == 200;
  }

  static Future<bool> deleteTodo(int id) async {
    final token = await TokenStorage.getToken();

    final response = await http.delete(
      Uri.parse("${Api.baseUrl}/todos/$id"),
      headers: {"Authorization": "Bearer $token", "Accept": "application/json"},
    );

    return response.statusCode == 200;
  }
}
