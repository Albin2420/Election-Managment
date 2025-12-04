import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AssignedBoothSection extends StatelessWidget {
  final String boothno;
  final String wardno;
  final String totalvoters;
  final String voted;
  const AssignedBoothSection({super.key, required this.boothno, required this.wardno, required this.totalvoters, required this.voted});

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
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage("assets/images/building.png"),
                      fit: BoxFit.contain, // or BoxFit.cover
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

          Text('You are managing Booth $boothno in Ward $wardno',
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),

          const SizedBox(height: 12),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text('Total Voters : $totalvoters',
                style: GoogleFonts.poppins(
                    fontSize: 13, color: Colors.white)),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text('Total Voted : $voted',
                style: GoogleFonts.poppins(
                    fontSize: 13, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
