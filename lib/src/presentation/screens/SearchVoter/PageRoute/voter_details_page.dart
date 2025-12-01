import 'package:election_management/src/presentation/screens/Homescreen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/SearchVoter/search_voter_controller.dart';
import '../../../widgets/NewVoter/go_home_button.dart';
import '../../../widgets/Search_Voter/PageRoute/other_members_section.dart';
import '../../../widgets/Search_Voter/PageRoute/voter_details_header.dart';
import '../../../widgets/Search_Voter/PageRoute/voter_profile_card.dart';

class VoterDetailsPage extends StatelessWidget {
  final String voterId;

  const VoterDetailsPage({super.key, required this.voterId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SearchVoterController>();
    final voter = controller.getVoterById(voterId);

    if (voter == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Voter Not Found')),
        body: const Center(child: Text('Voter details not found')),
      );
    }

    final otherMembers = controller.allVoters
        .where((v) => v.houseNumber == voter.houseNumber && v.id != voter.id)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          const VoterDetailsHeader(),
          const Divider(height: 1, color: Color(0xFFE0E0E0)),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 25),
              child: Column(
                children: [
                  VoterProfileCard(voter: voter),
                  const SizedBox(height: 24),
                  OtherMembersSection(
                      members: otherMembers,
                      houseNumber: voter.houseNumber),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GoHomeButton(onTap: () => Get.to(HomeScreen())),
          ],
        )
      ),
    );
  }
}
