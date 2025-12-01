import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/model/votermodel.dart';

class VoterCard extends StatelessWidget {
  final VoterModel voter;
  VoterCard({super.key, required this.voter});

  // Local observable to track "Our Voter" state
  final RxBool isVoter = false.obs;

  @override
  Widget build(BuildContext context) {
    // initialize local observable with the current voter state
    isVoter.value = voter.isOurVoter ?? false;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 6),
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
                    "assets/images/default_profile.png",
                    width: 60,
                    height: 60,
                    fit: BoxFit.contain,
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
              return SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    isVoter.value = !isVoter.value; // Toggle state
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isVoter.value
                        ? const Color(0xFF4CAF50) // Green for "Our Voter"
                        : Colors.white, // White for "Mark as Our Voter"
                    foregroundColor: isVoter.value
                        ? Colors
                              .white // White text for "Our Voter"
                        : const Color(
                            0xFF6B7280,
                          ), // Gray text for "Mark as Our Voter"
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        8,
                      ), // Smaller corner radius
                      side: BorderSide(
                        color: isVoter.value
                            ? const Color(
                                0xFF4CAF50,
                              ) // Green border for "Our Voter"
                            : const Color(
                                0xFFD1D5DB,
                              ), // Light gray border for "Mark as Our Voter"
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        isVoter.value
                            ? 'assets/images/thumbsup.png'
                            : 'assets/images/round_tick_grey.png',
                        width: 30,
                        height: 30,
                        color: isVoter.value ? Colors.white : null,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isVoter.value ? 'Our Voter' : 'Mark as Our Voter',
                        style: TextStyle(
                          color: isVoter.value
                              ? Colors.white
                              : const Color(0xFF6B7280),
                        ),
                      ),
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
