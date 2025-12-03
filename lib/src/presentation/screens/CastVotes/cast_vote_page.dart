import 'package:election_management/src/presentation/controller/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/CastVotes/cast_votes_controller.dart';
import '../../widgets/CastVotes/cast_voter_header.dart';
import '../../widgets/CastVotes/quick_jump_widget.dart';
import '../../widgets/CastVotes/serial_number_widget.dart';

class CastVotesPage extends StatelessWidget {
  const CastVotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CastVotesController());
    final hmctrl = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F1),
      body: Column(
        children: [
          const CastVoterHeader(),
          const Divider(height: 1, color: Color(0xFFE0E0E0)),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        QuickJumpWidget(limit: hmctrl.totalvoters.value),
                        SizedBox(height: 20),
                        SerialNumberWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
