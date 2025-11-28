import 'dart:developer';

import 'package:election_management/src/data/repositories/profile/profile_repo_impl.dart';
import 'package:election_management/src/domain/repositories/profile/profile_repo.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  ProfileRepo prf = ProfileRepoImpl();

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  Future<void> fetchUser() async {
    try {
      final res = await prf.getMydetails();
      res.fold(
        (l) {
          log("failed");
        },
        (R) {
          log("success");
        },
      );
    } catch (e) {
      log("⚠️ Error in fetchUser():$e");
    }
  }
}
