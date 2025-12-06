import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/MarkVoter/mark_voter_controller.dart';

class PreviousButton extends StatelessWidget {
  const PreviousButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MarkVoterController>();

    return Obx(() {
      final isEnabled = controller.hasPreviousPage.value;

      return GestureDetector(
        onTap: isEnabled ? () => controller.goToPreviousPage() : null,
        child: Opacity(
          opacity: isEnabled ? 1.0 : 0.5,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.green.shade800,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_sharp,
                    color: Colors.black,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "Previous",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}