import 'dart:async';
import 'dart:developer';
import 'package:election_management/src/data/repositories/Booth/booth_repo_impl.dart';
import 'package:election_management/src/data/repositories/statitics/status_repo_impl.dart';
import 'package:election_management/src/domain/repositories/Booth/booth_repo.dart';
import 'package:election_management/src/domain/repositories/statitics/status_repo.dart';
import 'package:election_management/src/presentation/controller/AppstartupController/app_startup_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  BoothRepo bth = BoothRepoImpl();
  StatussRepo stats = StatusRepoImpl();

  //Boothdetails
  RxString boothId = RxString("");
  RxInt wardNumber = RxInt(-1);
  RxInt boothNumber = RxInt(-1);
  RxInt totalvoters = RxInt(-1);
  RxString boothName = RxString("");
  RxString wardName = RxString("");
  RxBool boothLoading = RxBool(true);

  //status
  RxnDouble percentage = RxnDouble();
  RxnInt remainingvoter = RxnInt();
  RxnString date = RxnString();
  RxnString time = RxnString();


  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    await getBoothDetails();
    getStatus();
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

  Future<void> getStatus() async {
    try {
      final res = await stats.getstatus();
      res.fold((l) {}, (R) {
        log("R:$R");
        percentage.value = 0.9;
        remainingvoter.value = 8;
        date.value= "12/12/12";
        time.value="12:12:12";
      });
    } catch (e) {
      log('⚠️ Error in getStatus():$e');
    }
  }

  Future<void> logout() async {
    Get.find<AppStartupController>().logout();
  }
}
