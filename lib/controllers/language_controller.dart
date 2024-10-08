import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  void changeLanguage(String languageCode, String countryCode) {
    var locale = Locale(languageCode, countryCode);
    Get.updateLocale(locale);
  }
}