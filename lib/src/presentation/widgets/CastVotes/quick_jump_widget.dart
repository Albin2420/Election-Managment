import 'package:election_management/src/presentation/controller/CastVotes/cast_votes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class QuickJumpWidget extends StatelessWidget {
  final int limit;
  final int step;

  const QuickJumpWidget({super.key, required this.limit, this.step = 100});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CastVotesController>();

    if (limit == 0) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
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
        child: Center(
          child: Text(
            "Voters are not available",
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      );
    }

    final List<String> ranges = [];
    for (int i = 1; i <= limit; i += step) {
      int end = (i + step - 1) > limit ? limit : (i + step - 1);
      ranges.add("$i - $end");
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Jump to Range",
            style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),

          Obx(() {
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(ranges.length, (index) {
                final range = ranges[index];
                final bool isSelected = controller.selectedRange.value == range;

                return GestureDetector(
                  onTap: () => controller.jumpToRange(range),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFE94B1B)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFFE94B1B)
                            : Colors.grey.shade400,
                      ),
                    ),
                    child: Text(
                      range,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : Colors.grey.shade700,
                      ),
                    ),
                  ),
                );
              }),
            );
          }),
        ],
      ),
    );
  }
}
