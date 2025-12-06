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
  final allVoters = <VoterModel>[]; // Store all voters for search

  // Pagination variables
  final currentPage = 1.obs;
  final hasNextPage = true.obs;
  final hasPreviousPage = false.obs;

  // Search variables
  final searchQuery = ''.obs;
  final isSearching = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchVoters();
  }

  Future<void> fetchVoters({int? pageNumber}) async {
    // Don't fetch if currently searching
    if (isSearching.value) return;

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

          // Store all voters for search functionality
          if (page == 1) {
            allVoters.clear();
          }
          allVoters.addAll(R['voters']);

          log("voterLength:${voters.length}");

          // Update pagination state
          currentPage.value = page;
          hasNextPage.value = R['voters'].isNotEmpty;
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
    if (hasNextPage.value && !isSearching.value) {
      await fetchVoters(pageNumber: currentPage.value + 1);
    }
  }

  Future<void> goToPreviousPage() async {
    if (hasPreviousPage.value && !isSearching.value) {
      await fetchVoters(pageNumber: currentPage.value - 1);
    }
  }

  void searchVoters(String query) {
    searchQuery.value = query.trim().toLowerCase();

    if (searchQuery.value.isEmpty) {
      // Reset to original list when search is cleared
      isSearching.value = false;
      fetchVoters(pageNumber: currentPage.value);
      return;
    }

    isSearching.value = true;

    // Filter voters based on search query
    voters.value = allVoters.where((voter) {
      // Search by name
      final name = voter.name?.toLowerCase() ?? '';

      // Search by guardian name
      final guardianName = voter.guardianName?.toLowerCase() ?? '';

      // Search by house number (convert int to string)
      final houseNumber = voter.houseNumber?.toString() ?? '';

      // Search by serial number (convert int to string)
      final serialNumber = voter.serialNumber?.toString() ?? '';

      // Search by sec_id_number
      final secIdNumber = voter.secIdNumber?.toLowerCase() ?? '';

      // Search by address
      final address = voter.address?.toLowerCase() ?? '';

      // Search by age (convert int to string)
      final age = voter.age?.toString() ?? '';

      // Search by gender
      final gender = voter.gender?.toLowerCase() ?? '';

      return name.contains(searchQuery.value) ||
          guardianName.contains(searchQuery.value) ||
          houseNumber.contains(searchQuery.value) ||
          serialNumber.contains(searchQuery.value) ||
          secIdNumber.contains(searchQuery.value) ||
          address.contains(searchQuery.value) ||
          age.contains(searchQuery.value) ||
          gender.contains(searchQuery.value);
    }).toList();
  }

  void clearSearch() {
    searchQuery.value = '';
    isSearching.value = false;
    fetchVoters(pageNumber: currentPage.value);
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