import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdp_case/controllers/login_controller.dart';
import 'package:mdp_case/widgets/product_list_widget.dart';
import 'package:mdp_case/widgets/user_profile.dart';
import 'package:mdp_case/controllers/language_controller.dart';

class HomeScreen extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
  final LanguageController languageController = Get.put(LanguageController());

  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'language'.tr,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Türkçe'),
                onTap: () {
                  languageController.changeLanguage('tr', 'TR');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('English'),
                onTap: () {
                  languageController.changeLanguage('en', 'US');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0, 
        title: Text('home'.tr, style: TextStyle(color: Colors.indigo[300])),
        iconTheme: const IconThemeData(color: Colors.white), 
        actions: [
        IconButton(
          icon: Icon(Icons.translate, color: Colors.grey[600]), 
          onPressed: () => _showLanguageBottomSheet(context),
        ),
        IconButton(
          icon: Icon(Icons.logout, color: Colors.grey[600]), 
          onPressed: () {
            loginController.logout();
          },
        ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"), 
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: AppBar().preferredSize.height + MediaQuery.of(context).padding.top), 
            const UserProfileWidget(),
            const Expanded(
              child: ProductListWidget(),
            ),
          ],
        ),
      ),
    );
  }
}