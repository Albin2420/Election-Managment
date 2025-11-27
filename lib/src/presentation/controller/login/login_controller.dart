import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // Text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void login() {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter username and password",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } else {
      Get.snackbar(
        "Login Successful",
        "Welcome $username",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF2F5DFE),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      // Navigate to next page or perform further logic here
    }
  }
}
