import 'package:election_management/src/data/repositories/Auth/auth_repo_impl.dart';
import 'package:election_management/src/domain/repositories/Auth/auth_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthController extends GetxController {
  final LoginRepo _loginRepo = LoginRepoImpl();

  // Text editing controllers
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
        (R) {
          EasyLoading.dismiss();
        },
      );
    }
  }
}
