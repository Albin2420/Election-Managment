import 'dart:developer';

import 'package:election_management/src/presentation/controller/RemainingVoterController/remaining_voter_controller.dart';
import 'package:election_management/src/presentation/controller/home/home_controller.dart';
import 'package:election_management/src/presentation/screens/RemainingVoters/widgets/filter.dart';
import 'package:election_management/src/presentation/screens/RemainingVoters/widgets/remaining_voters_header.dart';
import 'package:election_management/src/presentation/screens/RemainingVoters/widgets/votercard_remain.dart';
import 'package:election_management/src/presentation/screens/SearchVoter/PageRoute/voter_details_page.dart';
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
                const SizedBox(height: 26),

                // ---------- STATUS CARDS ----------
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StatusCard(
                    iconImage: 'assets/images/grey_home.png',
                    title: 'Total Remaining',
                    onTap: () {},
                    bgColor: Colors.red,
                    count: '${ctrl.remainingvoter.value}',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StatusCard(
                    iconImage: 'assets/images/grey_home.png',
                    title: 'Our Voters Remaining',
                    onTap: () {},
                    bgColor: Colors.green,
                    count: '${ctrl.ourVoters.value! - ctrl.ourVoted.value!}',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StatusCard(
                    iconImage: 'assets/images/grey_home.png',
                    title: 'Others Remaining',
                    onTap: () {},
                    bgColor: Colors.blue,
                    count: '5',
                  ),
                ),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FiltersCard(
                    onOurVotersTap: () {
                      log("message");
                      ctrlr.toggleOurVoters();
                    },
                  ),
                ),

                ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: ctrlr.result.length,
                  shrinkWrap: true, // important
                  physics:
                      NeverScrollableScrollPhysics(), // disable inner scroll
                  itemBuilder: (context, index) {
                    final voter = ctrlr.result[index];

                    return GestureDetector(
                      onTap: () {
                        log("isOur:${voter.isOurVoter}");
                        Get.to(() => VoterDetailsPage(currenTVoter: voter));
                      },
                      child: VoterCard(
                        name: voter.name,
                        serial: '${voter.serialNumber}',
                        house: '${voter.houseNumber}',
                        id: '${voter.secIdNumber}',
                        ourVoter: voter.isOurVoter ?? false,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
