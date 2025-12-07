import 'dart:developer';

import 'package:election_management/src/data/model/votermodel.dart';
import 'package:election_management/src/data/repositories/remaing_voters/remaining_voters_repo_impl.dart';
import 'package:election_management/src/domain/repositories/remaining_voters_repo/remaining_voters_repo.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/state_manager.dart';

class RemainingVoterController extends GetxController {
  RemainingVotersRepo rp = RemainingVotersRepoImpl();
  RxList<VoterModel> result = <VoterModel>[].obs;
  RxBool ourVotersOnly = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetch(isvoted: false, isourVoter: false);
  }

  Future<void> fetch({required bool isvoted, required bool isourVoter}) async {
    try {
      EasyLoading.show();
      final res = await rp.remaingVoters(
        isourVoter: isourVoter,
        isvoted: isvoted,
      );
      res.fold(
        (l) {
          EasyLoading.dismiss();
        },
        (R) {
          final List<dynamic> resultData = R['searchResult'] ?? [];
          result.value = resultData
              .map((e) => e is VoterModel ? e : VoterModel.fromJson(e))
              .toList();
          EasyLoading.dismiss();
        },
      );
    } catch (e) {
      log('ERROR:$e');
      EasyLoading.dismiss();
    }
  }

  void toggleOurVoters() {
    ourVotersOnly.value = !ourVotersOnly.value;

    if (ourVotersOnly.value) {
      fetch(isourVoter: true, isvoted: false);
    } else {
      fetch(isvoted: false, isourVoter: false);
    }
  }
}
