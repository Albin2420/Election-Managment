import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/AddVoter/add_voter_controller.dart';

class AddVoterButton extends StatelessWidget {
  const AddVoterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddVoterController>();

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () => controller.addVoter(),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2F5DFE),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/addvoter.png',
              width: 28,
              height: 28,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              'Add Voter',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
