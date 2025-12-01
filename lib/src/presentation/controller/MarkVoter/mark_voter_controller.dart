import 'dart:developer';

import 'package:election_management/src/data/model/votermodel.dart';
import 'package:election_management/src/data/repositories/voters_repo/voters_repo_impl.dart';
import 'package:election_management/src/domain/repositories/voters/voters_repo.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class MarkVoterController extends GetxController {
  VotersRepo _votersRepo = VotersRepoImpl();
  final voters = <VoterModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchVoters();
  }

  Future<void> fetchVoters() async {
    EasyLoading.show();
    try {
      final res = await _votersRepo.fetchAllVoters(pageNumber: 1);
      res.fold(
        (l) {
          EasyLoading.dismiss();
        },
        (R) {
          log("R:$R");
          voters.value = R['voters'];
          log("voterLength:${voters.length}");
          EasyLoading.dismiss();
        },
      );
    } catch (e) {
      EasyLoading.dismiss();
      log("⚠️ Error in fetchVoters :$e");
    }
  }
}
