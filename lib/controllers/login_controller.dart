import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var rememberMe = false.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSavedCredentials();
  }

  void _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString('username') ?? '';
    password.value = prefs.getString('password') ?? '';
    rememberMe.value = prefs.getBool('rememberMe') ?? false;
  }

  void login() async {
    if (username.value.isEmpty || password.value.isEmpty) {
      Get.snackbar('Hata', 'Kullanıcı adı ve şifre boş olamaz.');
      return;
    }

    isLoading(true);
    final response = await http.post(
      Uri.parse('https://dummyjson.com/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username.value,
        'password': password.value,
        'expiresInMins': 30,
      }),
    );

    if (response.statusCode == 200) {
      var user = jsonDecode(response.body);

      if (rememberMe.value) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', username.value);
        await prefs.setString('password', password.value);
        await prefs.setBool('rememberMe', rememberMe.value);
      } else {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('username');
        await prefs.remove('password');
        await prefs.remove('rememberMe');
      }

      Get.offNamed('/home', arguments: user);
    } else {
      Get.snackbar('Hata', 'Giriş başarısız.');
    }

    isLoading(false);
  }
  

  void logout() async {
    username.value = '';
    password.value = '';
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('password');
    await prefs.remove('rememberMe');
    Get.offAllNamed('/'); 
  }
}