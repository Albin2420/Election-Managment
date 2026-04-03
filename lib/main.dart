import "dart:developer";

import "package:election_management/src/app.dart";
import "package:flutter/material.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");
    runApp(const ElectionManagment());
  } catch (e) {
    log("💥 exception in main():$e");
  }
}
