// import 'dart:developer';
// import 'package:get/get.dart';
//
// class VoterModel {
//   final String id;
//   final String name;
//   final String houseNumber;
//   final String electoralId;
//   final String serialNumber;
//   final String phoneNumber;
//   final String address;
//   final String photoUrl;
//   final String status; // "Our Voter", "Opposition", etc.
//   bool isSearched;
//
//   VoterModel({
//     required this.id,
//     required this.name,
//     required this.houseNumber,
//     required this.electoralId,
//     required this.serialNumber,
//     required this.phoneNumber,
//     required this.address,
//     this.photoUrl = '',
//     this.status = 'Our Voter',
//     this.isSearched = false,
//   });
// }
//
// class SearchVoterController extends GetxController {
//   // Observables
//   final searchQuery = ''.obs;
//   final searchResults = <VoterModel>[].obs;
//   final searchedVoters = <String>[].obs;
//
//   // All voters data
//   final List<VoterModel> allVoters = [
//     VoterModel(
//       id: '1',
//       name: 'Rajesh Kumar',
//       houseNumber: 'H-101',
//       electoralId: 'ELC001234',
//       serialNumber: '001',
//       phoneNumber: '9876543210',
//       address: '123 MG Road, Ward 5',
//       status: 'Our Voter',
//     ),
//     VoterModel(
//       id: '2',
//       name: 'Priya Sharma',
//       houseNumber: 'H-101',
//       electoralId: 'ELC001235',
//       serialNumber: '002',
//       phoneNumber: '9876543211',
//       address: '124 MG Road, Ward 5',
//       status: 'Our Voter',
//     ),
//     VoterModel(
//       id: '3',
//       name: 'Vikram Singh',
//       houseNumber: 'H-104',
//       electoralId: 'ELC001238',
//       serialNumber: '005',
//       phoneNumber: '9876543212',
//       address: '127 MG Road, Ward 5',
//       status: 'Our Voter',
//     ),
//     VoterModel(
//       id: '4',
//       name: 'Sunita Devi',
//       houseNumber: 'H-103',
//       electoralId: 'ELC001237',
//       serialNumber: '004',
//       phoneNumber: '9876543213',
//       address: '126 MG Road, Ward 5',
//       status: 'Our Voter',
//     ),
//   ];
//
//   @override
//   void onInit() {
//     super.onInit();
//     ever(searchQuery, (_) => performSearch());
//   }
//
//   void updateSearchQuery(String query) {
//     searchQuery.value = query.trim();
//   }
//
//   void performSearch() {
//     if (searchQuery.isEmpty) {
//       searchResults.clear();
//       return;
//     }
//
//     final query = searchQuery.value.toLowerCase();
//
//     final results = allVoters.where((voter) {
//       return voter.name.toLowerCase().contains(query) ||
//           voter.houseNumber.toLowerCase().contains(query) ||
//           voter.electoralId.toLowerCase().contains(query) ||
//           voter.serialNumber.toLowerCase().contains(query);
//     }).toList();
//
//     searchResults.assignAll(results);
//   }
//
//   // Check if search has results
//   bool get hasResults => searchResults.isNotEmpty;
//
//   // Check if search has been performed
//   bool get hasSearched => searchQuery.isNotEmpty;
//
//   /// Mark a voter as searched
//   void searchVoterAsSearched(String voterId) {
//     if (!searchedVoters.contains(voterId)) {
//       searchedVoters.add(voterId);
//
//       final voter = allVoters.firstWhere((v) => v.id == voterId);
//       voter.isSearched = true;
//       log("Success ${voter.name} has been marked as searched");
//     } else {
//       log("info, This voter is already marked as searched");
//     }
//   }
//
//   /// Unmark searched voter
//   void unsearchVoter(String voterId) {
//     searchedVoters.remove(voterId);
//
//     final voter = allVoters.firstWhere((v) => v.id == voterId);
//     voter.isSearched = false;
//   }
//
//   bool isVoterSearched(String voterId) {
//     return searchedVoters.contains(voterId);
//   }
//
//   int searchedVotersCount() {
//     return searchedVoters.length;
//   }
//
//   // Get voter by ID
//   VoterModel? getVoterById(String voterId) {
//     try {
//       return allVoters.firstWhere((v) => v.id == voterId);
//     } catch (e) {
//       return null;
//     }
//   }
// }
import 'dart:developer';
import 'package:get/get.dart';

class VoterModel {
  final String id;
  final String name;
  final String houseNumber;
  final String electoralId;
  final String serialNumber;
  final String phoneNumber;
  final String address;
  final String photoUrl;
  final String status; // "Our Voter", "Opposition", etc.
  bool isSearched;

  VoterModel({
    required this.id,
    required this.name,
    required this.houseNumber,
    required this.electoralId,
    required this.serialNumber,
    required this.phoneNumber,
    required this.address,
    this.photoUrl = '',
    this.status = 'Our Voter',
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
      name: 'Rajesh Kumar',
      houseNumber: 'H-101',
      electoralId: 'ELC001234',
      serialNumber: '001',
      phoneNumber: '9876543210',
      address: '123 MG Road, Ward 5',
      status: 'Our Voter',
    ),
    VoterModel(
      id: '2',
      name: 'Priya Sharma',
      houseNumber: 'H-101',
      electoralId: 'ELC001235',
      serialNumber: '002',
      phoneNumber: '9876543211',
      address: '124 MG Road, Ward 5',
      status: 'Our Voter',
    ),
    VoterModel(
      id: '3',
      name: 'Vikram Singh',
      houseNumber: 'H-104',
      electoralId: 'ELC001238',
      serialNumber: '005',
      phoneNumber: '9876543212',
      address: '127 MG Road, Ward 5',
      status: 'Our Voter',
    ),
    VoterModel(
      id: '4',
      name: 'Sunita Devi',
      houseNumber: 'H-103',
      electoralId: 'ELC001237',
      serialNumber: '004',
      phoneNumber: '9876543213',
      address: '126 MG Road, Ward 5',
      status: 'Our Voter',
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
      log("Search cleared - query is empty");
      return;
    }

    final query = searchQuery.value.toLowerCase();
    log("Performing search for: '$query'");

    final results = allVoters.where((voter) {
      return voter.name.toLowerCase().contains(query) ||
          voter.houseNumber.toLowerCase().contains(query) ||
          voter.electoralId.toLowerCase().contains(query) ||
          voter.serialNumber.toLowerCase().contains(query);
    }).toList();

    searchResults.assignAll(results);
    log("Search results: ${results.length} found");

    if (results.isEmpty) {
      log("No results found for query: '$query'");
    } else {
      for (var voter in results) {
        log("Found voter: ${voter.name}");
      }
    }
  }

  // Check if search has results
  bool get hasResults => searchResults.isNotEmpty;

  // Check if search has been performed
  bool get hasSearched => searchQuery.isNotEmpty;

  /// Mark a voter as searched
  void searchVoterAsSearched(String voterId) {
    if (!searchedVoters.contains(voterId)) {
      searchedVoters.add(voterId);

      final voter = allVoters.firstWhere((v) => v.id == voterId);
      voter.isSearched = true;
      log("Success ${voter.name} has been marked as searched");
    } else {
      log("info, This voter is already marked as searched");
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

  // Get voter by ID
  VoterModel? getVoterById(String voterId) {
    try {
      return allVoters.firstWhere((v) => v.id == voterId);
    } catch (e) {
      return null;
    }
  }
}