import 'package:election_management/src/presentation/controller/RemainingVoterController/remaining_voter_controller.dart';
import 'package:election_management/src/presentation/controller/home/home_controller.dart';
import 'package:election_management/src/presentation/screens/RemainingVoters/widgets/filter.dart';
import 'package:election_management/src/presentation/screens/RemainingVoters/widgets/remaining_voters_header.dart';
import 'package:election_management/src/presentation/screens/RemainingVoters/widgets/votercard_remain.dart';
import 'package:election_management/src/presentation/screens/SearchVoter/PageRoute/voter_details_page.dart';
import 'package:election_management/src/presentation/widgets/status_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
                  child: FiltersCard(
                    onOurVotersTap: () {
                      ctrlr.toggleOurVoters();
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Text(
                    "Found ${ctrlr.remainingVoters} result(s)",
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),

                // ---------- VOTER LIST ----------
                ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: ctrlr.result.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final voter = ctrlr.result[index];

                    return GestureDetector(
                      onTap: () {
                        Get.to(() => VoterDetailsPage(currenTVoter: voter));
                      },
                      child: VoterCard(
                        name: voter.name,
                        serial: '${voter.serialNumber}',
                        house: '${voter.houseNumber}',
                        id: '${voter.secIdNumber}',
                        ourVoter: voter.isOurVoter ?? false,
                        voted: voter.hasVoted ?? false,
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: ctrlr.previous.value == null
                              ? null
                              : () => ctrlr.loadPrevious(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ctrlr.previous.value == null
                                ? Colors.grey
                                : Colors.green,
                            foregroundColor: Colors.white, // text & icon color
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.arrow_back),
                              SizedBox(width: 8),
                              Text("Previous"),
                            ],
                          ),
                        ),

                        ElevatedButton(
                          onPressed: ctrlr.next.value == null
                              ? null
                              : () => ctrlr.loadNext(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ctrlr.next.value == null
                                ? Colors.grey
                                : Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text("Next"),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                const SizedBox(height: 30),
              ],
            ),
          );
        }),
      ),
    );
  }
}
