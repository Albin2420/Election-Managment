import 'dart:developer';
import 'package:election_management/src/data/repositories/Booth/booth_repo_impl.dart';
import 'package:election_management/src/domain/repositories/Booth/booth_repo.dart';
import 'package:election_management/src/presentation/controller/AppstartupController/app_startup_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  BoothRepo bth = BoothRepoImpl();

  //Boothdetails
  RxString boothId = RxString("");
  RxInt wardNumber = RxInt(-1);
  RxInt boothNumber = RxInt(-1);
  RxInt totalvoters = RxInt(-1);
  RxString boothName = RxString("");
  RxString wardName = RxString("");
  RxBool boothLoading = RxBool(true);

  @override
  void onInit() {
    super.onInit();
    getBoothDetails();
  }

  Future<void> getBoothDetails() async {
    try {
      boothLoading.value = true;
      final res = await bth.getMyboothDetails();
      res.fold((l) {}, (R) {
        boothId.value = R['lsg_booth'];
        boothNumber.value = R['boothNumber'];
        wardNumber.value = R['wardNumber'];
        totalvoters.value = R['totalVoters'];
        boothName.value = R['boothName'];
        wardName.value = R['wardName'];
        boothLoading.value = false;
      });
    } catch (e) {
      log("⚠️ Error in getBoothDetails():$e");
    }
  }

  Future<void> logout() async {
    Get.find<AppStartupController>().logout();
  }
}
