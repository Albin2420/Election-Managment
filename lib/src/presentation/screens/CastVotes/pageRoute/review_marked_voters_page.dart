import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/CastVotes/cast_votes_controller.dart';
import '../../../widgets/CastVotes/pageRoute/cancel_confirm_buttons.dart';
import '../../../widgets/CastVotes/pageRoute/marked_voter_card.dart';
import '../../../widgets/CastVotes/pageRoute/review_mark_header.dart';
import '../../../widgets/MarkVoter/go_home_button.dart';
class ReviewMarkedVotersPage extends StatelessWidget {
  const ReviewMarkedVotersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CastVotesController>();

    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F1),
      body: Column(
        children: [
          const ReviewMarkedHeader(),    // 🔥 Header widget
          const Divider(height: 1, color: Color(0xFFE0E0E0)),

          // 🔥 Marked Voters List Widget
          Expanded(
            child: Obx(() {
              final markedVoters = controller.getMarkedVoters();

              if (markedVoters.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inbox_outlined,
                          size: 64, color: Colors.grey.shade400),
                      const SizedBox(height: 16),
                      Text(
                        "No voters marked",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: markedVoters.length,
                itemBuilder: (context, index) {
                  return MarkedVoterCard(voter: markedVoters[index]);
                },
              );
            }),
          ),

          // 🔥 Cancel & Confirm Buttons Widget
          const CancelConfirmButtons(),

          // 🔥 Already existing global widget
        ],
      ),
      bottomNavigationBar: SafeArea(child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const GoHomeButton(),
        ],
      )),
    );
  }
}
