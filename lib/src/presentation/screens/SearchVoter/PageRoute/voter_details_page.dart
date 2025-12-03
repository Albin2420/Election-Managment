import 'package:election_management/src/data/model/votermodel.dart';
import 'package:election_management/src/presentation/widgets/Search_Voter/PageRoute/voter_profile_card.dart';
import 'package:flutter/material.dart';
import '../../../widgets/Search_Voter/PageRoute/voter_details_header.dart';

class VoterDetailsPage extends StatelessWidget {
  final VoterModel currenTVoter;

  const VoterDetailsPage({super.key, required this.currenTVoter});

  @override
  Widget build(BuildContext context) {
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
                  VoterProfileCard(voter: currenTVoter),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
