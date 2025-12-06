import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../controller/MarkVoter/mark_voter_controller.dart';
import '../../widgets/MarkVoter/mark_voter_header.dart';
import '../../widgets/MarkVoter/voter_card.dart';
import '../../widgets/MarkVoter/search_field.dart';
import '../../widgets/MarkVoter/previous_button.dart';
import '../../widgets/MarkVoter/next_button.dart';

class MarkVoterScreen extends StatelessWidget {
  const MarkVoterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MarkVoterController());

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Column(
          children: [
            const MarkVoterHeader(),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: SearchField(),
            ),

            Expanded(
              child: Obx(() {
                if (controller.voters.isEmpty && EasyLoading.isShow) {
                  return const Center(child: Text(""));
                }

                if (controller.voters.isEmpty && !EasyLoading.isShow) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          controller.isSearching.value
                              ? "No results found"
                              : "No voters Found",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        if (controller.isSearching.value) ...[
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () => controller.clearSearch(),
                            child: const Text("Clear search"),
                          ),
                        ],
                      ],
                    ),
                  );
                }

                return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  children: [
                    // Show search info if searching
                    if (controller.isSearching.value)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${controller.voters.length} result(s) found',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            TextButton(
                              onPressed: () => controller.clearSearch(),
                              child: const Text('Clear'),
                            ),
                          ],
                        ),
                      ),

                    ...controller.voters.map(
                          (voter) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: VoterCard(voter: voter),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Hide pagination buttons when searching
                    if (!controller.isSearching.value)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          PreviousButton(),
                          NextButton(),
                        ],
                      ),

                    const SizedBox(height: 40),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}