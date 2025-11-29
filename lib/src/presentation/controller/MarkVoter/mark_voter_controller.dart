import 'package:get/get.dart';

class MarkVoterController extends GetxController {
  final voters = <VoterData>[
    VoterData(
      id: '001',
      name: 'Rajesh Kumar',
      serialNumber: '001',
      houseNumber: 'H-101',
      electoralId: 'ELC001234',
      image: 'assets/images/rajesh.png',
      isMarked: false,
    ),
    VoterData(
      id: '002',
      name: 'Priya Sharma',
      serialNumber: '002',
      houseNumber: 'H-101',
      electoralId: 'ELC001235',
      image: 'assets/images/priya.png',
      isMarked: false,
    ),
    VoterData(
      id: '003',
      name: 'Amit Patel',
      serialNumber: '003',
      houseNumber: 'H-102',
      electoralId: 'ELC001236',
      image: 'assets/images/amit.png',
      isMarked: false,
    ),
    VoterData(
      id: '004',
      name: 'Sunita Devi',
      serialNumber: '004',
      houseNumber: 'H-103',
      electoralId: 'ELC001237',
      image: 'assets/images/sunita.png',
      isMarked: false,
    ),
    VoterData(
      id: '005',
      name: 'Vikram Singh',
      serialNumber: '005',
      houseNumber: 'H-104',
      electoralId: 'ELC001238',
      image: 'assets/images/vikram.png',
      isMarked: false,
    ),
  ].obs;

  final searchQuery = ''.obs;

  List<VoterData> get filteredVoters {
    if (searchQuery.value.isEmpty) {
      return voters;
    }
    return voters
        .where((voter) =>
    voter.name.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
        voter.houseNumber.toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void toggleVoterMark(String voterId) {
    final index = voters.indexWhere((voter) => voter.id == voterId);
    if (index != -1) {
      voters[index].isMarked.value = !voters[index].isMarked.value;
      voters.refresh();
    }
  }

  int get markedVotersCount {
    return voters.where((voter) => voter.isMarked.value).length;
  }
}

class VoterData {
  final String id;
  final String name;
  final String serialNumber;
  final String houseNumber;
  final String electoralId;
  final String image;
  final RxBool isMarked;

  VoterData({
    required this.id,
    required this.name,
    required this.serialNumber,
    required this.houseNumber,
    required this.electoralId,
    required this.image,
    required bool isMarked,
  }) : isMarked = RxBool(isMarked);
}