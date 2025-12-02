import 'dart:developer';
import 'package:election_management/src/data/model/votermodel.dart';
import 'package:election_management/src/data/repositories/search_voter/search_voter_repo_impl.dart';
import 'package:election_management/src/domain/repositories/search_voter/search_voter_repo.dart';
import 'package:get/get.dart';

class SearchVoterController extends GetxController {
  final SearchVoterRepo srp = SearchVoterRepoImpl();

  RxList<VoterModel> searchResult = <VoterModel>[].obs;

  Future<void> searchVoter({required String key}) async {
    if (key.isEmpty) {
      searchResult.clear();
      return;
    }

    try {
      final resp = await srp.searchVoters(key: key);

      resp.fold(
        (l) {
          log("❌ Failure: ${l.message}");
          searchResult.clear();
        },
        (R) {
          final List<dynamic> resultData = R['searchResult'] ?? [];
          searchResult.value = resultData
              .map((e) => e is VoterModel ? e : VoterModel.fromJson(e))
              .toList();
        },
      );
    } catch (e) {
      log("⚠️ Unexpected error in searchVoter(): $e");
      searchResult.clear();
    }
  }

  void clearSearch() {
    searchResult.clear();
  }
}
