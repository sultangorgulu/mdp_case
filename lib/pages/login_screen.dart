import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Size mediaSize;
  final LoginController controller = Get.put(LoginController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      emailController.text = prefs.getString('username') ?? '';
      passwordController.text = prefs.getString('password') ?? '';
      rememberUser = prefs.getBool('rememberMe') ?? false;
      setState(() {});
    } catch (e) {
      print("Error loading credentials: $e");
    }
  }

  Future<void> _saveCredentials() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', emailController.text);
      await prefs.setString('password', passwordController.text);
      await prefs.setBool('rememberMe', rememberUser);
    } catch (e) {
      print("Error saving credentials: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned(top: 80, child: _buildTop()),
            Positioned(bottom: 0, child: _buildBottom()),
          ],
        ),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.abc,
              size: 100,
              color: Colors.white,
            ),
            Text(
              "HOŞ GELDİNİZ",
              style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.displayLarge,
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Lütfen Giriş Yapmak İçin Bilgilerinizi Giriniz.",
              style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.displayLarge,
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildTabBar(),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Container(
  margin: const EdgeInsets.all(15),
  decoration: BoxDecoration(
    color: Colors.grey[200],
    borderRadius: BorderRadius.circular(15),
  ),
  child: TabBar(
    labelColor: Colors.black,
    unselectedLabelColor: Colors.grey,
    indicator: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    indicatorSize: TabBarIndicatorSize.label, 
    indicatorPadding: const EdgeInsets.symmetric(horizontal: -50, vertical: 5), 
    labelPadding: const EdgeInsets.symmetric(horizontal: 10),
    tabs: const [
      Tab(text: "Giriş"),
      Tab(text: "Kayıt Ol"),
    ],
  ),
),

          const SizedBox(height: 20),
          SizedBox(
            height: 400,
            child: TabBarView(
              children: [
                _buildLoginForm(),
                _buildRegisterForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGreyText("Email"),
        _buildInputField(emailController),
        const SizedBox(height: 20),
        _buildGreyText("Şifre"),
        _buildInputField(passwordController, isPassword: true),
        const SizedBox(height: 20),
        _buildRememberForgot(),
        const SizedBox(height: 20),
        Obx(() => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ElevatedButton(
                onPressed: () async {
                  controller.username(emailController.text);
                  controller.password(passwordController.text);
                  controller.rememberMe(rememberUser);
                  await _saveCredentials();
                  controller.login();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.blue,
                  minimumSize: const Size.fromHeight(60),
                ),
                child: const Text("Giriş", style: TextStyle(color: Colors.white)),
              )),
      ],
    );
  }

  Widget _buildRegisterForm() {
    return Column(
      children: [
        _buildGreyText("Email"),
        _buildInputField(emailController),
        const SizedBox(height: 20),
        _buildGreyText("Şifre"),
        _buildInputField(passwordController, isPassword: true),
        const SizedBox(height: 20),
        _buildGreyText("Şifreyi Doğrula"),
        _buildInputField(passwordController, isPassword: true),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            debugPrint("Kayıt Bilgileri - Email : ${emailController.text}");
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            backgroundColor: Colors.blue,
            minimumSize: const Size.fromHeight(60),
          ),
          child: const Text("Kayıt Ol", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: const TextStyle(color: Colors.black87),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
              )
            : const Icon(Icons.done),
      ),
      obscureText: isPassword && !isPasswordVisible,
      textAlignVertical: TextAlignVertical.center,
    );
  }

  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: rememberUser,
              onChanged: (value) {
                setState(() {
                  rememberUser = value!;
                });
              },
            ),
            _buildGreyText("Beni Hatırla"),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            "Şifremi Unuttum",
            style: TextStyle(
              color: Colors.blue,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ],
    );
  }
}
