import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/SearchVoter/search_voter_controller.dart';
import 'member_card.dart';

class OtherMembersSection extends StatelessWidget {
  final List<VoterModel> members;
  final String houseNumber;

  const OtherMembersSection({
    super.key,
    required this.members,
    required this.houseNumber,
  });

  @override
  Widget build(BuildContext context) {
    if (members.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black54.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.people_outline,
                  color: Color(0xFF8900E4), size: 24),
              const SizedBox(width: 8),
              Text(
                "Other Members in $houseNumber",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ⬇️ SEPARATED WIDGET
          ...members.map((member) => MemberCard(member: member)),
        ],
      ),
    );
  }
}
