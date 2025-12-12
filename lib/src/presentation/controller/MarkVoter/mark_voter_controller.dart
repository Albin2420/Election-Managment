import 'dart:developer';
import 'package:election_management/src/data/model/votermodel.dart';
import 'package:election_management/src/data/repositories/isourvoter/is_our_voter_repo_impl.dart';
import 'package:election_management/src/data/repositories/voters_repo/voters_repo_impl.dart';
import 'package:election_management/src/domain/repositories/isourvoter/is_our_voter_repo.dart';
import 'package:election_management/src/domain/repositories/voters/voters_repo.dart';
import 'package:election_management/src/presentation/controller/home/home_controller.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class MarkVoterController extends GetxController {
  IsOurVoterRepo isOurVoterRepo = IsOurVoterRepoImpl();
  VotersRepo votersRepo = VotersRepoImpl();
  final controller = Get.find<HomeController>();
  RxList<VoterModel> voters = <VoterModel>[].obs;
  final allVoters = <VoterModel>[]; // Full list cache
  final searchText = "".obs;

  RxInt currentPage = 1.obs;
  RxnString next = RxnString();
  RxnString previous = RxnString();

  @override
  void onInit() {
    super.onInit();
    fetchVoters(pageNumber: currentPage.value);
  }

  Future<bool> fetchVoters({required int pageNumber}) async {
    try {
      if (!EasyLoading.isShow) {
        EasyLoading.show();

        final res = await votersRepo.fetchAllVoters(pageNumber: pageNumber);

        bool success = false;

        await res.fold(
          (l) async {
            success = false;
            EasyLoading.dismiss();
          },
          (R) async {
            final List<dynamic> list = R['voters'] ?? [];

            // Convert to VoterModel
            allVoters.clear();
            allVoters.addAll(
              list
                  .map((e) => e is VoterModel ? e : VoterModel.fromJson(e))
                  .toList(),
            );

            voters.assignAll(allVoters);

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
      log("⚠️ Error in fetchVoters: $e");
      EasyLoading.dismiss();
      return false;
    }
  }

  void searchVoters(String query) {
    searchText.value = query;

    if (query.isEmpty) {
      voters.assignAll(allVoters);
      return;
    }

    final lower = query.toLowerCase();

    final results = allVoters.where((v) {
      return v.name.toLowerCase().contains(lower) ||
          v.guardianName?.toLowerCase().contains(lower) == true ||
          v.serialNumber.toString().contains(lower) ||
          v.houseNumber.toString().contains(lower);
    }).toList();

    voters.assignAll(results);
  }

  Future<void> loadNext() async {
    if (next.value == null) return;

    int oldPage = currentPage.value;
    currentPage.value++;

    bool ok = await fetchVoters(pageNumber: currentPage.value);

    if (!ok) {
      currentPage.value = oldPage;
    }
  }

  Future<void> loadPrevious() async {
    if (previous.value == null || currentPage.value <= 1) return;

    int oldPage = currentPage.value;
    currentPage.value--;

    bool ok = await fetchVoters(pageNumber: currentPage.value);

    if (!ok) {
      currentPage.value = oldPage;
    }
  }

  Future<bool> addVotertoOur({required dynamic isOurvoterData}) async {
    try {
      EasyLoading.show();
      final res = await isOurVoterRepo.ourVoter(ourVoter: isOurvoterData);
      return res.fold(
        (l) {
          EasyLoading.dismiss();
          return false;
        },
        (r) async {
          await controller.getStatus();
          EasyLoading.dismiss();
          return true;
        },
      );
    } catch (e) {
      log("⚠️ Error in addVotertoOur():$e");
      return false;
    }
  }

  @override
  void onClose() {
    EasyLoading.dismiss();
    super.onClose();
  }
}
