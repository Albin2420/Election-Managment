import 'package:election_management/src/data/model/votermodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/MarkVoter/mark_voter_controller.dart';

class VoterCard extends StatelessWidget {
  final VoterModel voter;
  const VoterCard({super.key, required this.voter});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    "assets/images/tick_mark.png",
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(voter.name),
                      Text("SN: ${voter.serialNumber}"),
                      Text("${voter.address}"),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Obx(() {
              final isVoter = voter.isOurVoter == true ? true : false;
              return SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isVoter
                        ? const Color(0xFF00C853)
                        : Colors.white,
                    side: BorderSide(
                      color: isVoter
                          ? const Color(0xFF00C853)
                          : const Color(0xFFE5E7EB),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        isVoter
                            ? 'assets/images/thumbsup.png'
                            : 'assets/images/round_tick_grey.png',
                        width: 30,
                        height: 30,
                        color: isVoter ? Colors.white : null,
                      ),
                      const SizedBox(width: 8),
                      Text(isVoter ? 'Our Voter' : 'Mark as Our Voter'),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
