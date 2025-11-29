import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/MarkVoter/mark_voter_controller.dart';
import '../../widgets/MarkVoter/mark_voter_header.dart';
import '../../widgets/MarkVoter/voter_card.dart';
import '../../widgets/MarkVoter/search_field.dart';
import '../../widgets/MarkVoter/go_home_button.dart';

class MarkVoterScreen extends StatelessWidget {
  const MarkVoterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MarkVoterController());

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Column(
          children: [
            const MarkVoterHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      const SearchField(),
                      const SizedBox(height: 20),
                      Obx(() {
                        final controller = Get.find<MarkVoterController>();
                        final filteredVoters = controller.filteredVoters;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Showing ${filteredVoters.length} voter(s)',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF6B7280),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ...filteredVoters
                                .asMap()
                                .entries
                                .map(
                                  (entry) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: VoterCard(voter: entry.value),
                              ),
                            )
                                .toList(),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
            const GoHomeButton(),
          ],
        ),
      ),
    );
  }
}