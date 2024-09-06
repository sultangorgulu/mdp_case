import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductController extends GetxController {
  var products = [].obs;
  var isLoading = false.obs;
  var page = 0.obs;

  void fetchProducts() async {
    isLoading(true);
    final response = await http.get(
      Uri.parse('https://dummyjson.com/products?limit=10&skip=${page.value * 10}&select=title,price'),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      products.addAll(data['products']);
      page.value += 1;
    } else {
      Get.snackbar('Hata', 'Ürünler yüklenemedi.');
    }

    isLoading(false);
  }
}
