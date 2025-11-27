import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ElectionManagment extends StatelessWidget {
  const ElectionManagment({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Election Managment',
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
    );
  }
}
