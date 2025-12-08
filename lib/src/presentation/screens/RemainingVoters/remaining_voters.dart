import 'package:election_management/src/presentation/controller/RemainingVoterController/remaining_voter_controller.dart';
import 'package:election_management/src/presentation/controller/home/home_controller.dart';
import 'package:election_management/src/presentation/screens/RemainingVoters/widgets/filter.dart';
import 'package:election_management/src/presentation/screens/RemainingVoters/widgets/quick_serial_number.dart';
import 'package:election_management/src/presentation/screens/RemainingVoters/widgets/quickjump_remaining_voters.dart';
import 'package:election_management/src/presentation/screens/RemainingVoters/widgets/remaining_voters_header.dart';
import 'package:election_management/src/presentation/widgets/status_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RemainingVoters extends StatelessWidget {
  const RemainingVoters({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrlr = Get.put(RemainingVoterController());
    final ctrl = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Obx(() {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const RemainingVoterHeader(),
                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StatusCard(
                    iconImage: 'assets/images/total_people.png',
                    title: 'Total Remaining',
                    onTap: () {},
                    bgColor: Color(0XFFFF6900),
                    count: '${ctrl.remainingvoter.value}',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StatusCard(
                    iconImage: 'assets/images/add_people.png',
                    title: 'Our Voters Remaining',
                    onTap: () {},
                    bgColor: Color(0XFF00C951),
                    count: '${ctrl.ourVoters.value! - ctrl.ourVoted.value!}',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StatusCard(
                    iconImage: 'assets/images/total_people.png',
                    title: 'Others Remaining',
                    onTap: () {},
                    bgColor: Color(0XFF2B7FFF),
                    count: '${ctrl.otherRemaining.value}',
                  ),
                ),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: QuickJumpWidgetRemainVoters(
                    limit: ctrl.totalvoters.value,
                  ),
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() {
                    // 🔥 Show FiltersCard only if a range is selected
                    if (ctrlr.currentRange.value.isEmpty) {
                      return SizedBox();
                    }

                    return FiltersCard(
                      onOurVotersTap: () {
                        ctrlr.toggleOurVoters();
                      },
                    );
                  }),
                ),
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SerialNumberWidget(),
                ),

                const SizedBox(height: 30),
              ],
            ),
          );
        }),
      ),
    );
  }
}
