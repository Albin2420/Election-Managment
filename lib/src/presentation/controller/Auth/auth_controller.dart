import 'package:election_management/src/data/repositories/Auth/auth_repo_impl.dart';
import 'package:election_management/src/domain/repositories/Auth/auth_repo.dart';
import 'package:election_management/src/presentation/controller/AppstartupController/app_startup_controller.dart';
import 'package:election_management/src/presentation/screens/Homescreen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../data/services/storage_service.dart';

class AuthController extends GetxController {
  final appstartupCtrl = Get.find<AppStartupController>();
  final LoginRepo _loginRepo = LoginRepoImpl();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill out this field");
    } else {
      EasyLoading.show();
      final resp = await _loginRepo.login(
        userName: username,
        password: password,
      );
      resp.fold(
        (l) {
          EasyLoading.dismiss();
          Fluttertoast.showToast(msg: l.message);
        },
        (R) async {
          await StorageService.saveTokens(
            accessToken: R['access_token'],
            refreshToken: R['refresh_token'],
          );
          Get.offAll(() => HomeScreen());
          EasyLoading.dismiss();
        },
      );
    }
  }
}
