import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/CastVotes/cast_votes_controller.dart';

class CancelConfirmButtons extends StatelessWidget {
  const CancelConfirmButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CastVotesController>();

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Obx(() {
        final hasVoters = controller.hasMarkedVoters;

        return Row(
          children: [
            // Cancel Button
            Expanded(
              child: GestureDetector(
                onTap: hasVoters
                    ? () {
                  Get.dialog(
                    AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      title: Text(
                        "Cancel All?",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      content: Text(
                        "Are you sure you want to cancel all marked voters?",
                        style: GoogleFonts.inter(fontSize: 14),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(),
                          child: Text(
                            "No",
                            style:
                            GoogleFonts.inter(color: Colors.grey),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back();
                            controller.cancelAllMarkedVoters();
                            Get.back();
                          },
                          child: Text(
                            "Yes, Cancel",
                            style: GoogleFonts.inter(
                              color: const Color(0xFFE94B1B),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                    : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color:
                    hasVoters ? Colors.white : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.close,
                        color: hasVoters
                            ? Colors.black87
                            : Colors.grey.shade400,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Cancel",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: hasVoters
                              ? Colors.black87
                              : Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Confirm Button
            Expanded(
              child: GestureDetector(
                onTap: hasVoters
                    ? () => controller.confirmMarkedVoters()
                    : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: hasVoters
                        ? const Color(0xFF4CAF50)
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check,
                        color: hasVoters
                            ? Colors.white
                            : Colors.grey.shade500,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Confirm as\nCasted Voters",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: hasVoters
                              ? Colors.white
                              : Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
