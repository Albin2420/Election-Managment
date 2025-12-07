import 'package:election_management/src/presentation/screens/RemainingVoters/remaining_voters.dart';
import 'package:election_management/src/presentation/widgets/optcard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 4,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(
            'Additional Options',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0C1A30),
            ),
          ),

          const SizedBox(height: 16),

          Optcard(
            iconImage: 'assets/images/delete-account.png',
            title: 'Remaining Voters',
            onTap: () {
              Get.to(() => RemainingVoters());
            },
            bgColor: Colors.orange.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}
