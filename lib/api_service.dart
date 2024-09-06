import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mdp_case/models/user.dart';

Future<User> fetchUserData() async {
  final response = await http.post(
    Uri.parse('https://dummyjson.com/auth/login'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'username': 'emilys',
      'password': 'emilyspass',
    }),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return User.fromJson(data);
  } else {
    throw Exception('Failed to login');
  }
}

