import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../controller/MarkVoter/mark_voter_controller.dart';
import '../../widgets/MarkVoter/mark_voter_header.dart';
import '../../widgets/MarkVoter/voter_card.dart';
import '../../widgets/MarkVoter/search_field.dart';

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
                  return const Center(
                    child: Text("", style: TextStyle(fontSize: 16)),
                  );
                } else if (controller.voters.isEmpty &&
                    EasyLoading.isShow == false) {
                  return const Center(
                    child: Text(
                      "No voters Found",
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                } else {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    itemCount: controller.voters.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: VoterCard(voter: controller.voters[index]),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
