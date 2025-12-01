
import 'dart:developer';
import 'package:get/get.dart';

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
        name: 'John Doe',
        houseNumber: '123',
        electoralId: 'EL001',
        serialNumber: '001'),
    VoterCastModel(
        id: '2',
        name: 'Jane Smith',
        houseNumber: '456',
        electoralId: 'EL002',
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

  // Navigate to review page
  void proceedToReview() {
    if (votedSerials.isEmpty) {
      Get.snackbar(
        'No Selection',
        'Please mark at least one voter before proceeding',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Navigate to review page
    Get.toNamed('/review-marked-voters');
    // Or use: Get.to(() => ReviewMarkedVotersPage());
  }
}