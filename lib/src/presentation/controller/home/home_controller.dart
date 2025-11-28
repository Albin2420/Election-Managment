import 'dart:developer';

import 'package:election_management/src/data/repositories/Booth/booth_repo_impl.dart';
import 'package:election_management/src/data/repositories/profile/profile_repo_impl.dart';
import 'package:election_management/src/domain/repositories/Booth/booth_repo.dart';
import 'package:election_management/src/domain/repositories/profile/profile_repo.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //Boothdetails

  RxString boothId = RxString("");

  ProfileRepo prf = ProfileRepoImpl();
  BoothRepo bth = BoothRepoImpl();

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
          getBoothDetails();
        },
      );
    } catch (e) {
      log("⚠️ Error in fetchUser():$e");
    }
  }

  Future<void> getBoothDetails() async {
    try {
      final res = await bth.getMyboothDetails();
      res.fold((l) {}, (R) {
        log("succes in getBoothDetails()");
      });
    } catch (e) {
      log("⚠️ Error in getBoothDetails():$e");
    }
  }
}
