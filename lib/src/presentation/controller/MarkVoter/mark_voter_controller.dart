import 'dart:developer';
import 'package:election_management/src/data/model/votermodel.dart';
import 'package:election_management/src/data/repositories/isourvoter/is_our_voter_repo_impl.dart';
import 'package:election_management/src/data/repositories/voters_repo/voters_repo_impl.dart';
import 'package:election_management/src/domain/repositories/isourvoter/is_our_voter_repo.dart';
import 'package:election_management/src/domain/repositories/voters/voters_repo.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class MarkVoterController extends GetxController {
  IsOurVoterRepo isOurVoterRepo = IsOurVoterRepoImpl();
  VotersRepo votersRepo = VotersRepoImpl();
  final voters = <VoterModel>[].obs;

  // Pagination variables
  final currentPage = 1.obs;
  final hasNextPage = true.obs;
  final hasPreviousPage = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchVoters();
  }

  Future<void> fetchVoters({int? pageNumber}) async {
    EasyLoading.show();
    try {
      final page = pageNumber ?? currentPage.value;
      final res = await votersRepo.fetchAllVoters(pageNumber: page);
      res.fold(
            (l) {
          EasyLoading.dismiss();
        },
            (R) {
          log("R:$R");
          voters.value = R['voters'];
          log("voterLength:${voters.length}");

          // Update pagination state
          currentPage.value = page;

          // Update hasNextPage based on response
          // Assuming the API returns empty list or specific flag when no more data
          hasNextPage.value = R['voters'].isNotEmpty;

          // Update hasPreviousPage
          hasPreviousPage.value = page > 1;

          EasyLoading.dismiss();
        },
      );
    } catch (e) {
      EasyLoading.dismiss();
      log("⚠️ Error in fetchVoters :$e");
    }
  }

  Future<void> goToNextPage() async {
    if (hasNextPage.value) {
      await fetchVoters(pageNumber: currentPage.value + 1);
    }
  }

  Future<void> goToPreviousPage() async {
    if (hasPreviousPage.value) {
      await fetchVoters(pageNumber: currentPage.value - 1);
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
            (r) {
          EasyLoading.dismiss();
          return true;
        },
      );
    } catch (e) {
      log("⚠️ Error in addVotertoOur():$e");
      return false;
    }
  }
}