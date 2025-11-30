import 'package:election_management/src/presentation/controller/home/home_controller.dart';
import 'package:election_management/src/presentation/screens/Addnewvoter/add_new_voter.dart';
import 'package:election_management/src/presentation/screens/MarkVoter/mark_voter_screen.dart';
import 'package:election_management/src/presentation/screens/SearchVoter/search_voter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/home_screen/action_card.dart';
import '../../widgets/home_screen/assigned_booth_section.dart';
import '../../widgets/home_screen/simple_option_card.dart';
import '../../widgets/home_screen/ward_booth_details.dart';
import '../../widgets/home_screen/home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(HomeController());
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(
                onLogout: () {
                  ctrl.logout();
                },
              ),
              const SizedBox(height: 24),
              Obx(() {
                if (ctrl.boothLoading.value == false) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        WardBoothDetails(
                          wardnumber: '${ctrl.wardNumber.value}',
                          boothnumber: '${ctrl.boothNumber.value}',
                          percentagevote: '0.00',
                          remainvote: '850',
                          totalvote: '850',
                          date: '27/11/25',
                          time: '12:52:33',
                        ),
                        SizedBox(height: 24),
                        AssignedBoothSection(
                          boothno: '${ctrl.boothNumber.value}',
                          wardno: '${ctrl.boothNumber.value}',
                          voteno: '849',
                        ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Quick Actions',
                            style: GoogleFonts.inter(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: ActionCard(
                            iconImage: "assets/images/person.png",
                            iconBgColor: Color(0xFF2F5DFE),
                            title: 'Add Voter',
                            subtitle: 'Register new voter',
                            onTap: () {
                              Get.to(() => AddNewVoterScreen());
                            },
                          ),
                        ),
                        const SizedBox(height: 16),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: ActionCard(
                            iconImage: "assets/images/round_tick.png",
                            iconBgColor: Color(0xFF00C853),
                            title: 'Mark Voter',
                            subtitle: 'Tag political alliance',
                            onTap: () {
                              Get.to(() => MarkVoterScreen());
                            },
                          ),
                        ),
                        const SizedBox(height: 16),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: ActionCard(
                            iconImage: "assets/images/search.png",
                            iconBgColor: Color(0xFFD946EF),
                            title: 'Search Voter',
                            subtitle: 'Find voter details',
                            onTap: () {
                              Get.to(() => SearchVoterPage());
                            },
                          ),
                        ),
                        const SizedBox(height: 16),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: ActionCard(
                            iconImage: "assets/images/white_tick.png",
                            iconBgColor: Color(0xFFFF9100),
                            title: 'Mark Voted',
                            subtitle: 'Record cast votes',
                            onTap: () {},
                          ),
                        ),

                        const SizedBox(height: 24),

                        const SimpleOptionCard(
                          iconImage: "assets/images/grey_home.png",
                          title: "Search Home",
                        ),

                        const SizedBox(height: 32),
                      ],
                    ),
                  );
                } else {
                  return SizedBox();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
