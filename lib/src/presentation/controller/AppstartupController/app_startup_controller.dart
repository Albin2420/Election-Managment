import 'dart:developer';
import 'package:election_management/src/presentation/screens/Auth/loginpage.dart';
import 'package:election_management/src/presentation/screens/Homescreen/home_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppStartupController extends GetxController {
  RxString accessToken = RxString("");
  RxString refreshToken = RxString("");
  final sh = FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();
    checkToken();
  }

  Future<void> checkToken() async {
    try {
      final storedAccess = await sh.read(key: 'accessToken');
      final storedRefresh = await sh.read(key: 'refreshToken');

      accessToken.value = storedAccess ?? "";
      refreshToken.value = storedRefresh ?? "";

      if (accessToken.value.isEmpty || refreshToken.value.isEmpty) {
        log("❌ Tokens Missing → Redirecting to LoginPage");
        Get.offAll(() => LoginPage());
      } else {
        log("✅ Tokens Found → Redirecting to HomePage");
        Get.offAll(() => HomeScreen());
      }
    } catch (e) {
      log("⚠️ Error in loadTokensAndNavigate(): $e");
      Get.offAll(() => LoginPage());
    }
  }

  Future<void> saveTokens({String? accessTk, String? refreshTk}) async {
    try {
      if (accessTk != null) {
        accessToken.value = accessTk;
        await sh.write(key: 'accessToken', value: accessTk);
      }

      if (refreshTk != null) {
        refreshToken.value = refreshTk;
        await sh.write(key: 'refreshToken', value: refreshTk);
      }
    } catch (e) {
      log("⚠️ Error in saveTokens():$e");
    }
  }

  Future<void> logout() async {
    Get.offAll(() => LoginPage());
  }
}
