import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/CastVotes/cast_votes_controller.dart';

class SerialNumberWidget extends StatelessWidget {
  const SerialNumberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CastVotesController>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Obx(() {
        final range = controller.currentRange.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Serial Numbers $range",
              style: GoogleFonts.inter(
                  fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: controller.getSerialNumbersForRange().map((serial) {
                return Obx(() {
                  final isSelected = controller.isSerialVoted(serial);

                  return GestureDetector(
                    onTap: () => controller.toggleSerialVote(serial),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFE94B1B)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFFE94B1B)
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Text(
                        serial,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color:
                          isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  );
                });
              }).toList(),
            ),
          ],
        );
      }),
    );
  }
}
