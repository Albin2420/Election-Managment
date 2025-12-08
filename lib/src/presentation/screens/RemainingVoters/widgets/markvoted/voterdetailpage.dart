import 'package:election_management/src/data/model/votermodel.dart';
import 'package:election_management/src/presentation/controller/RemainingVoterController/remaining_voter_controller.dart';
import 'package:election_management/src/presentation/screens/RemainingVoters/widgets/markvoted/voterdetailcard.dart';
import 'package:election_management/src/presentation/widgets/Search_Voter/PageRoute/voter_details_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VoterDetailsPage extends StatelessWidget {
  final VoterModel currenTVoter;

  const VoterDetailsPage({super.key, required this.currenTVoter});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<RemainingVoterController>();
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          const VoterDetailsHeader(),
          const Divider(height: 1, color: Color(0xFFE0E0E0)),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
              child: Column(
                children: [
                  VoterDetailcard(
                    voter: currenTVoter,
                    onMarkVoted: () {
                      ctrl.markasVoted(id: currenTVoter.id);
                    },
                  ),
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
