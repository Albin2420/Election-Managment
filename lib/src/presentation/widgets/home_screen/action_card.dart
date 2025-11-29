import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../screens/Addnewvoter/add_new_voter.dart';
import '../../screens/MarkVoter/mark_voter_screen.dart';

class ActionCard extends StatelessWidget {
  final String iconImage;
  final Color iconBgColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ActionCard({
    super.key,
    required this.iconImage,
    required this.iconImage, // <-- updated
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(16),
      onTap: () {
        if (title == 'Add Voter') {
          Get.to(() => const AddNewVoterScreen());
        }
        if (title == 'Mark Voter') {
          Get.to(() => const MarkVoterScreen());
        }

      },child:
     Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image Container
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(16),
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image Container
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset(
                iconImage,
                height: 35,
                width: 35,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 16),

            // Title
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 5),

            // Subtitle
            Text(
              subtitle,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.grey.shade800,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
