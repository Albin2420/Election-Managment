import 'dart:developer';
import 'package:get/get.dart';

import '../../screens/CastVotes/pageRoute/review_marked_voters_page.dart';

class VoterCastModel {
  final String id;
  final String name;
  final String houseNumber;
  final String electoralId;
  final String serialNumber;
  bool hasVoted;

  VoterCastModel({
    required this.id,
    required this.name,
    required this.houseNumber,
    required this.electoralId,
    required this.serialNumber,
    this.hasVoted = false,
  });
}

class CastVotesController extends GetxController {
  final searchQuery = ''.obs;
  final searchResults = <VoterCastModel>[].obs;

  final castedVotes = <String>[].obs;
  final currentRange = '0 - 5'.obs;

  final votedSerials = <String>[].obs;

  final List<VoterCastModel> allVoters = [
    VoterCastModel(
        id: '1',
        name: 'Rajesh Kumar',
        houseNumber: 'H-101',
        electoralId: 'ELC001234',
        serialNumber: '001'),
    VoterCastModel(
        id: '2',
        name: 'Priya Sharma',
        houseNumber: 'H-101',
        electoralId: 'ELC001235',
        serialNumber: '002'),
    VoterCastModel(
        id: '3',
        name: 'Robert Johnson',
        houseNumber: '789',
        electoralId: 'EL003',
        serialNumber: '003'),
    VoterCastModel(
        id: '4',
        name: 'Emily Brown',
        houseNumber: '101',
        electoralId: 'EL004',
        serialNumber: '004'),
    VoterCastModel(
        id: '5',
        name: 'Vikram Singh',
        houseNumber: 'H-104',
        electoralId: 'ELC001238',
        serialNumber: '005'),
  ];

  @override
  void onInit() {
    ever(searchQuery, (_) => performSearch());
    super.onInit();
  }

  void updateSearchQuery(String value) {
    searchQuery.value = value.trim();
  }

  void performSearch() {
    if (searchQuery.isEmpty) {
      searchResults.clear();
      return;
    }

    final query = searchQuery.value.toLowerCase();
    final results = allVoters.where((v) {
      return v.name.toLowerCase().contains(query) ||
          v.serialNumber.toLowerCase().contains(query) ||
          v.electoralId.toLowerCase().contains(query);
    }).toList();

    searchResults.assignAll(results);
  }

  // RANGE LOGIC
  void jumpToRange(String range) {
    currentRange.value = range;
  }

  List<String> getSerialNumbersForRange() {
    final parts = currentRange.value.split('-');
    final start = int.parse(parts[0].trim());
    final end = int.parse(parts[1].trim());

    return [
      for (int i = start; i <= end; i++) i.toString().padLeft(3, '0')
    ];
  }

  // SERIAL MARKING
  void toggleSerialVote(String serial) {
    if (votedSerials.contains(serial)) {
      votedSerials.remove(serial);
      log("Unmarked Serial $serial removed");
    } else {
      votedSerials.add(serial);
      log("marked Serial $serial added");
    }
  }

  bool isSerialVoted(String serial) => votedSerials.contains(serial);

  // Get count of marked voters
  int get markedCount => votedSerials.length;

  // Check if any voter is marked
  bool get hasMarkedVoters => votedSerials.isNotEmpty;

  // Get voter details by serial number
  VoterCastModel? getVoterBySerial(String serial) {
    try {
      return allVoters.firstWhere((voter) => voter.serialNumber == serial);
    } catch (e) {
      return null;
    }
  }

  // Get list of marked voters
  List<VoterCastModel> getMarkedVoters() {
    return votedSerials
        .map((serial) => getVoterBySerial(serial))
        .where((voter) => voter != null)
        .cast<VoterCastModel>()
        .toList();
  }

  // Remove voter from marked list
  void removeMarkedVoter(String serial) {
    votedSerials.remove(serial);
    log("Removed voter with serial $serial from marked list");
  }

  // Navigate to review page
  void proceedToReview() {
    if (votedSerials.isEmpty) {
      log("no selection,please mark atleast one voter before proceeding");
      return;
    }

    // Navigate to review page
    Get.to(() => const ReviewMarkedVotersPage());
  }

  // Cancel all marked voters
  void cancelAllMarkedVoters() {
    votedSerials.clear();
    log("All marked voters cancelled");
  }

  // Confirm marked voters
  void confirmMarkedVoters() {
    // Here you can add API call or database save logic
    final count = markedCount;

    Get.back(); // Go back to previous page

    log("Success $count voter(s) confirmed as casted voters");

    // Clear the marked voters after confirmation
    votedSerials.clear();
  }
}