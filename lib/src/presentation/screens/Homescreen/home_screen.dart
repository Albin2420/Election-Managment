import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeader(),        // <-- SEPARATED WIDGET
              const SizedBox(height: 24),

              const WardBoothDetails(wardnumber: '5', boothnumber: '12', percentagevote: '0.00', remainvote: '850', totalvote: '850', date: '27/11/25', time: '12:52:33',),
              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: const AssignedBoothSection(boothno: '12', wardno: '5', voteno: '849',),
              ),
              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Text(
                  'Quick Actions',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const ActionCard(
                  icon: Icons.person_add,
                  iconBgColor: Color(0xFF2F5DFE),
                  title: 'Add Voter',
                  subtitle: 'Register new voter',
                ),
              ),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const ActionCard(
                  icon: Icons.check_circle,
                  iconBgColor: Color(0xFF00C853),
                  title: 'Mark Voter',
                  subtitle: 'Tag political alliance',
                ),
              ),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const ActionCard(
                  icon: Icons.search,
                  iconBgColor: Color(0xFFD946EF),
                  title: 'Search Voter',
                  subtitle: 'Find voter details',
                ),
              ),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const ActionCard(
                  icon: Icons.check_box_outlined,
                  iconBgColor: Color(0xFFFF9100),
                  title: 'Mark Voted',
                  subtitle: 'Record cast votes',
                ),
              ),
              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Additional Options',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              const SimpleOptionCard(
                icon: Icons.home_outlined,
                title: 'Search Home',
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
