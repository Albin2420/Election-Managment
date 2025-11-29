import 'dart:developer';

import 'package:get/get.dart';

class VoterModel {
  final String id;
  final String name;
  final String houseNumber;
  final String electoralId;
  final String serialNumber;
  bool isSearched;

  VoterModel({
    required this.id,
    required this.name,
    required this.houseNumber,
    required this.electoralId,
    required this.serialNumber,
    this.isSearched = false,
  });
}

class SearchVoterController extends GetxController {
  // Observables
  final searchQuery = ''.obs;
  final searchResults = <VoterModel>[].obs;
  final searchedVoters = <String>[].obs;

  // All voters data
  final List<VoterModel> allVoters = [
    VoterModel(
      id: '1',
      name: 'John Doe',
      houseNumber: '123',
      electoralId: 'EL001',
      serialNumber: 'SN001',
    ),
    VoterModel(
      id: '2',
      name: 'Jane Smith',
      houseNumber: '456',
      electoralId: 'EL002',
      serialNumber: 'SN002',
    ),
    VoterModel(
      id: '3',
      name: 'Robert Johnson',
      houseNumber: '789',
      electoralId: 'EL003',
      serialNumber: 'SN003',
    ),
    VoterModel(
      id: '4',
      name: 'Emily Brown',
      houseNumber: '101',
      electoralId: 'EL004',
      serialNumber: 'SN004',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    ever(searchQuery, (_) => performSearch());
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.trim();
  }

  void performSearch() {
    if (searchQuery.isEmpty) {
      searchResults.clear();
      return;
    }

    final query = searchQuery.value.toLowerCase();

    final results = allVoters.where((voter) {
      return voter.name.toLowerCase().contains(query) ||
          voter.houseNumber.toLowerCase().contains(query) ||
          voter.electoralId.toLowerCase().contains(query) ||
          voter.serialNumber.toLowerCase().contains(query);
    }).toList();

    searchResults.assignAll(results);
  }

  /// Mark a voter as searched
  void searchVoterAsSearched(String voterId) {
    if (!searchedVoters.contains(voterId)) {
      searchedVoters.add(voterId);

      final voter = allVoters.firstWhere((v) => v.id == voterId);

      voter.isSearched = true;
      log("Success ${voter.name} has been marked as searched");
    } else {
      log("info,This voter is already marked as searched ");
    }
  }

  /// Unmark searched voter
  void unsearchVoter(String voterId) {
    searchedVoters.remove(voterId);

    final voter = allVoters.firstWhere((v) => v.id == voterId);
    voter.isSearched = false;
  }

  bool isVoterSearched(String voterId) {
    return searchedVoters.contains(voterId);
  }

  int searchedVotersCount() {
    return searchedVoters.length;
  }
}
