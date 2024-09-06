import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'home': 'Home',
      'products': 'Products',
      'logout': 'Logout',
      'language': 'Language',
      'popular products' : 'Popular Products',
      'show all' : 'Show All'

    },
    'tr_TR': {
      'home': 'Ana Sayfa',
      'products': 'Ürünler',
      'logout': 'Çıkış Yap',
      'language': 'Dil',
      'popular products' : 'Popüler Ürünler',
      'show all' : 'Tümünü Gör'
    },
  };
}