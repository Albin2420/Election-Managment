import 'package:election_management/src/presentation/widgets/home_screen/info_card_static.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'info_card.dart';
import 'vote_card.dart';

class WardBoothDetails extends StatelessWidget {
  final String wardnumber;
  final String boothnumber;
  final String wardName;
  final String boothName;
  final String percentagevote;
  final String remainvote;
  final String totalvote;
  final String date;
  final String time;
  const WardBoothDetails({
    super.key,
    required this.wardnumber,
    required this.boothnumber,
    required this.percentagevote,
    required this.remainvote,
    required this.totalvote,
    required this.date,
    required this.time,
    required this.wardName,
    required this.boothName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset('assets/images/ward.png', width: 40, height: 40),
                const SizedBox(width: 10),
                Text(
                  'Ward & Booth Details',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            InfoCardStatic(
              bgColor: const Color(0xFFE3F2FD),
              label: 'Ward',
              value: wardnumber,
              labelColor: const Color(0xFF3A7BFE),
              valueColor: const Color(0xFF0A3D91),
              imageName: 'assets/images/home.png',
              borderBaseColor: const Color(0xFFAEDAFF),
              tag: wardName,
            ),

            const SizedBox(height: 20),

            InfoCard(
              bgColor: const Color(0xFFF3E5F5),
              label: 'Booth Number',
              value: boothnumber,
              labelColor: const Color(0xFF9B5CFF),
              valueColor: const Color(0xFF4B0082),
              imageName: 'assets/images/tick.png',
              borderBaseColor: const Color(0xFFFFC9DF),
              tag: boothName,
            ),

            const SizedBox(height: 20),

            VoteCard(
              bgColor: const Color(0xFFE8F5E8),
              label: 'Voting Percentage',
              value: '$percentagevote%',
              borderColor: const Color(0xFF9FF3A1),
              labelColor: const Color(0xFF1B5E20),
              valueColor: const Color(0xFF0B3D14),
              imagePath: 'assets/images/green.png',
            ),

            const SizedBox(height: 20),

            VoteCard(
              bgColor: const Color(0xFFFFF3E0),
              label: 'Remaining Voters',
              value: remainvote,
              borderColor: const Color(0xFFFFE3C2),
              labelColor: const Color(0xFFEF6C00),
              valueColor: const Color(0xFFB34A00),
              imagePath: 'assets/images/orange.png',
            ),

            const SizedBox(height: 20),

            VoteCard(
              bgColor: const Color(0xFFE3F2FD),
              label: 'Total Voters',
              value: totalvote,
              borderColor: const Color(0xFFAEDAFF),
              labelColor: const Color(0xFF0D47A1),
              valueColor: const Color(0xFF062A66),
              imagePath: 'assets/images/blue.png',
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border.all(color: Colors.grey.shade200, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: Colors.grey.shade700,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Last updated: $date, $time',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
