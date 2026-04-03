import 'dart:developer';

import 'package:election_management/src/data/services/storage/storage_service.dart';
import 'package:election_management/src/presentation/screens/Auth/loginpage.dart';
import 'package:election_management/src/presentation/screens/Homescreen/home_screen.dart';
import 'package:get/get.dart';

class AppStartupController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkToken();
  }

  Future<void> checkToken() async {
    try {
      final accessToken = await StorageService.getAccessToken();
      final refreshToken = await StorageService.getRefreshToken();

      if (accessToken != null || refreshToken != null) {
        Get.offAll(() => HomeScreen());
      } else {
        Get.offAll(() => LoginPage());
      }
    } catch (e) {
      log("⚠️ Error in loadTokensAndNavigate(): $e");
      Get.offAll(() => LoginPage());
    }
  }

  Future<void> logout() async {
    await StorageService.clear();
    await Get.offAll(() => LoginPage());
  }
}
