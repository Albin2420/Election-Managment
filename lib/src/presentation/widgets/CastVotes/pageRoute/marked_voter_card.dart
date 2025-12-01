import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/CastVotes/cast_votes_controller.dart';

class MarkedVoterCard extends StatelessWidget {
  // final VoterModel voter;
  final VoterCastModel voter;

  const MarkedVoterCard({super.key, required this.voter});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CastVotesController>();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Serial Number
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: const Color(0xFFE94B1B),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                voter.serialNumber,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  voter.name,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Electoral ID: ${voter.electoralId}",
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "House: ${voter.houseNumber}",
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          // Profile Image
          Container(
            width: 60,
            height: 60,
            child: Image.asset(
              'assets/images/default_profile.png',
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(width: 12),

          // Remove Button
          GestureDetector(
            onTap: () {
              controller.removeMarkedVoter(voter.serialNumber);
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFFEE9E7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.close,
                color: Color(0xFFE94B1B),
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
