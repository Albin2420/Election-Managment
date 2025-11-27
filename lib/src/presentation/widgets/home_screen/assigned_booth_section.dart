import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AssignedBoothSection extends StatelessWidget {
  final String boothno;
  final String wardno;
  final String voteno;
  const AssignedBoothSection({super.key, required this.boothno, required this.wardno, required this.voteno});

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
                  // color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.apartment_outlined,
                    color: Colors.white),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  'Your Assigned Booth',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Text('You are managing Booth $boothno in Ward $wardno',
              style: GoogleFonts.poppins(
                  fontSize: 14, color: Colors.white)),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text('Total Registered Voters: $voteno',
                style: GoogleFonts.poppins(
                    fontSize: 13, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
