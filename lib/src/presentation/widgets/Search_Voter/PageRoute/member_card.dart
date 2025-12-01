import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/SearchVoter/search_voter_controller.dart';

class MemberCard extends StatelessWidget {
  final VoterModel member;

  const MemberCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // PHOTO BOX
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: member.photoUrl.isEmpty
                ? Icon(Icons.person, size: 30, color: Colors.grey.shade500)
                : ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                member.photoUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // NAME & SN
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "SN: ${member.serialNumber}",
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
