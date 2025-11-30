import 'package:election_management/src/presentation/controller/AppstartupController/app_startup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
    Get.put(AppStartupController());
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
              child: Image.asset(
                scale: 6,
                'assets/images/splash.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
