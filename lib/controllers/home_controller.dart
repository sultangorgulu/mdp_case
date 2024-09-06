import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeController extends GetxController {
  var user = {}.obs;
  var products = [].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    user(Get.arguments);
    fetchProducts();
  }

  void fetchProducts() async {
    isLoading(true);
    final response = await http.get(
      Uri.parse('https://dummyjson.com/products?limit=10'),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      products(data['products']);
    } else {
      Get.snackbar('Hata', 'Ürünler yüklenemedi.');
    }

    isLoading(false);
  }
}
