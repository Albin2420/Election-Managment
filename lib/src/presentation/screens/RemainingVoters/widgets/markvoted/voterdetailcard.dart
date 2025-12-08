import 'package:election_management/src/data/model/votermodel.dart';
import 'package:election_management/src/presentation/widgets/Search_Voter/PageRoute/voter_detail_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VoterDetailcard extends StatelessWidget {
  final VoterModel voter;
  final VoidCallback onMarkVoted;

  const VoterDetailcard({
    super.key,
    required this.voter,
    required this.onMarkVoted,
  });

  @override
  Widget build(BuildContext context) {
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
          // Profile Image
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20),
            ),

            child: (voter.photo == null || voter.photo!.isEmpty)
                ? Icon(Icons.person, size: 60, color: Colors.grey)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      voter.photo!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stack) =>
                          Icon(Icons.person, size: 60, color: Colors.grey),
                    ),
                  ),
          ),

          const SizedBox(height: 20),

          Text(
            voter.name,
            style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 24),

          VoterDetailItem(
            icon: Icons.person,
            iconColor: const Color(0xFF8900E4),
            label: "Gaurdian Name",
            value: "${voter.guardianName}",
            backgroundColor: const Color(0xFFF8F8F8),
          ),

          const SizedBox(height: 12),

          VoterDetailItem(
            icon: Icons.tag,
            iconColor: const Color(0xFF8900E4),
            label: "Serial Number",
            value: "${voter.serialNumber}",
            backgroundColor: const Color(0xFFF8F8F8),
          ),

          const SizedBox(height: 12),

          VoterDetailItem(
            icon: Icons.home_outlined,
            iconColor: const Color(0xFF8900E4),
            label: "House Number",
            value: "${voter.houseNumber}",
            backgroundColor: const Color(0xFFF8F8F8),
          ),

          const SizedBox(height: 12),

          VoterDetailItem(
            icon: Icons.credit_card,
            iconColor: const Color(0xFF8900E4),
            label: "Electoral ID",
            value: voter.secIdNumber ?? "",
            backgroundColor: const Color(0xFFF8F8F8),
          ),

          const SizedBox(height: 12),

          VoterDetailItem(
            icon: Icons.location_on_outlined,
            iconColor: const Color(0xFF8900E4),
            label: "Address",
            value: "${voter.address}",
            backgroundColor: const Color(0xFFF3E5FF),
          ),

          const SizedBox(height: 24),

          // Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              voter.isOurVoter == true
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4F8E8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Our Voter",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 16, 201, 155),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),

              SizedBox(width: 4),
              GestureDetector(
                onTap: onMarkVoted,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 8, 5, 147),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "mark as voted",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
