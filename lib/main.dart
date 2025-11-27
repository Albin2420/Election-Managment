import 'package:device_preview/device_preview.dart';
import "package:election_management/src/app.dart";
import "package:flutter/material.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    DevicePreview(
      enabled: true,            // 🔥 Enable/Disable DevicePreview
      builder: (context) => ElectionManagment(),
    ),
  );
}
