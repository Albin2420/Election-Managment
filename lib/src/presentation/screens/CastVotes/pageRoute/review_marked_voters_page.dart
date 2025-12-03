import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/CastVotes/cast_votes_controller.dart';
import '../../../widgets/CastVotes/pageRoute/cancel_confirm_buttons.dart';
import '../../../widgets/CastVotes/pageRoute/marked_voter_card.dart';
import '../../../widgets/CastVotes/pageRoute/review_mark_header.dart';

class ReviewMarkedVotersPage extends StatelessWidget {
  const ReviewMarkedVotersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CastVotesController>();

    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F1),
      body: Column(
        children: [
          const ReviewMarkedHeader(),
          const Divider(height: 1, color: Color(0xFFE0E0E0)),

          Expanded(
            child: Obx(() {
              final markedVoters = controller.voterbySerial;

              if (markedVoters.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inbox_outlined,
                        size: 64,
                        color: Colors.grey.shade400,
                      ),
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
                  return MarkedVoterCard(
                    voter: markedVoters[index],
                    onCancel: () {
                      EasyLoading.show();
                      controller.voterbySerial.removeAt(index);

                      Future.delayed(const Duration(milliseconds: 500), () {
                        EasyLoading.dismiss();
                      });
                    },
                  );
                },
              );
            }),
          ),

          CancelConfirmButtons(
            onCancel: () {
              Get.back();
            },
            onConfirm: () {
              controller.confirmMarkedVoters();
            },
          ),
        ],
      ),
    );
  }
}
