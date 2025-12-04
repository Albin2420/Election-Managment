import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AssignedBoothSection extends StatelessWidget {
  final String boothno;
  final String wardno;

  final int? ourtotalvoters; // Nullable int
  final int? voted; // Nullable int

  const AssignedBoothSection({
    super.key,
    required this.boothno,
    required this.wardno,
    this.ourtotalvoters,
    this.voted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2F5DFE),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/building.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  'Your Assigned Booth',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Text(
            'You are managing Booth $boothno in Ward $wardno',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 12),

          // 👉 Show if ourtotalvoters is not null
          if (ourtotalvoters != null) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Total Our Voters : $ourtotalvoters',
                style: GoogleFonts.poppins(fontSize: 13, color: Colors.white),
              ),
            ),
            const SizedBox(height: 12),
          ],

          // 👉 Show if voted is not null
          if (voted != null) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Voted : $voted',
                style: GoogleFonts.poppins(fontSize: 13, color: Colors.white),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
