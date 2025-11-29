import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchVoterHeader extends StatelessWidget {
  const SearchVoterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black54.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(Icons.arrow_back, size: 24, color: Colors.black),
            ),
            const SizedBox(width: 12),
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: const Color(0xFF8900E4),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.search, color: Colors.white, size: 35),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Search Voter",
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Find voter by name, house, or ID",
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey.shade900,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
