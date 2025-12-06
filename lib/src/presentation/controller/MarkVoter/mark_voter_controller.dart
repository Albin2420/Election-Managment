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

  final allVoters = <VoterModel>[]; // Store full list
  final voters = <VoterModel>[].obs; // Filtered list for UI
  final searchText = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchVoters();
  }

  Future<void> fetchVoters() async {
    EasyLoading.show();
    try {
      final res = await votersRepo.fetchAllVoters(pageNumber: 1);
      res.fold(
        (l) {
          EasyLoading.dismiss();
        },
        (R) {
          log("R:$R");
          allVoters.clear();
          allVoters.addAll(R['voters']);

          voters.assignAll(allVoters);
          EasyLoading.dismiss();
        },
      );
    } catch (e) {
      EasyLoading.dismiss();
      log("⚠️ Error in fetchVoters :$e");
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
