import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdp_case/translations.dart';
import 'pages/login_screen.dart';
import 'pages/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping',
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(
      Theme.of(context).textTheme,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      translations: Messages(), 
      locale: Get.deviceLocale, 
      fallbackLocale: const Locale('en', 'US'), 
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () =>  const LoginScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
      ],
    );
  }
}