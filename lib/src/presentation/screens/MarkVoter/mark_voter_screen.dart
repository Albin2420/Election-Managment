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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: const SearchField(),
            ),

            Expanded(
              child: Obx(() {
                if (controller.voters.isEmpty && EasyLoading.isShow) {
                  return const Center(child: Text(""));
                }

                if (controller.voters.isEmpty && !EasyLoading.isShow) {
                  return const Center(
                    child: Text(
                      "No voters Found",
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }

                return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  children: [
                    ...controller.voters.map(
                          (voter) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: VoterCard(voter: voter),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// ------------ Next & Previous Under List ------------
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
