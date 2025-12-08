import 'dart:developer';
import 'package:election_management/src/data/model/votermodel.dart';
import 'package:election_management/src/data/repositories/remaing_voters/remaining_voters_repo_impl.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/state_manager.dart';

class RemainingVoterController extends GetxController {
  final RemainingVotersRepoImpl rp = RemainingVotersRepoImpl();

  RxList<VoterModel> result = <VoterModel>[].obs;
  RxBool ourVotersOnly = false.obs;

  RxnInt remainingVoters = RxnInt();
  RxInt currentPage = 1.obs;

  RxnString next = RxnString();
  RxnString previous = RxnString();

  @override
  void onInit() {
    super.onInit();
    fetch(isvoted: false, isourVoter: false, pageNumber: currentPage.value);
  }

  Future<bool> fetch({
    required bool isvoted,
    required bool isourVoter,
    required int pageNumber,
  }) async {
    try {
      if (!EasyLoading.isShow) {
        EasyLoading.show();

        final res = await rp.remaingVoters(
          isvoted: isvoted,
          isourVoter: isourVoter,
          pageNumber: pageNumber,
        );

        bool success = false;

        await res.fold(
          (l) async {
            success = false;
            EasyLoading.dismiss();
          },
          (R) async {
            final List<dynamic> list = R['searchResult'] ?? [];

            result.value = list
                .map((e) => e is VoterModel ? e : VoterModel.fromJson(e))
                .toList();

            remainingVoters.value = R['count'];
            next.value = R['next'];
            previous.value = R['previous'];

            success = true;
            EasyLoading.dismiss();
          },
        );

        return success;
      } else {
        return false;
      }
    } catch (e) {
      log("❌ Error: $e");
      EasyLoading.dismiss();
      return false;
    }
  }

  void toggleOurVoters() async {
    ourVotersOnly.value = !ourVotersOnly.value;

    currentPage.value = 1;

    await fetch(
      isvoted: false,
      isourVoter: ourVotersOnly.value,
      pageNumber: currentPage.value,
    );
  }

  Future<void> loadNext() async {
    if (next.value == null) return;

    int oldPage = currentPage.value;
    currentPage.value++;

    bool ok = await fetch(
      isvoted: false,
      isourVoter: ourVotersOnly.value,
      pageNumber: currentPage.value,
    );

    if (!ok) {
      currentPage.value = oldPage;
    }
  }

  Future<void> loadPrevious() async {
    if (previous.value == null || currentPage.value <= 1) return;

    int oldPage = currentPage.value;
    currentPage.value--;

    bool ok = await fetch(
      isvoted: false,
      isourVoter: ourVotersOnly.value,
      pageNumber: currentPage.value,
    );

    if (!ok) {
      currentPage.value = oldPage;
    }
  }

  @override
  void onClose() {
    EasyLoading.dismiss();
    super.onClose();
  }
}
