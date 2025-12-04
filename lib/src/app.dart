import 'package:election_management/src/presentation/screens/ServerDownPage/server_down_page.dart';
import 'package:election_management/src/presentation/screens/SplashScreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ElectionManagment extends StatelessWidget {
  const ElectionManagment({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Election Management',
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      // home: SplashScreen(),
      home: MaintenancePage(),
    );
  }
}
