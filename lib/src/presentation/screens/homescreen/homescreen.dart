import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.09),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              image: const DecorationImage(
                                image: AssetImage(
                                  'assets/images/tick_mark.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Election Management',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Booth Officer Dashboard',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: const Icon(
                                      Icons.logout,
                                      size: 22,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const SizedBox(width: 1),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Logout',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildWardBoothDetails(),
              const SizedBox(height: 24),
              _buildAssignedBoothSection(),
              const SizedBox(height: 24),
              Text(
                'Quick Actions',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              _buildActionCard(
                icon: Icons.person_add,
                iconBgColor: const Color(0xFF2F5DFE),
                title: 'Add Voter',
                subtitle: 'Register new voter',
              ),
              const SizedBox(height: 16),
              _buildActionCard(
                icon: Icons.check_circle,
                iconBgColor: const Color(0xFF00C853),
                title: 'Mark Voter',
                subtitle: 'Tag political alliance',
              ),
              const SizedBox(height: 16),
              _buildActionCard(
                icon: Icons.search,
                iconBgColor: const Color(0xFFD946EF),
                title: 'Search Voter',
                subtitle: 'Find voter details',
              ),
              const SizedBox(height: 16),
              _buildActionCard(
                icon: Icons.check_box_outlined,
                iconBgColor: const Color(0xFFFF9100),
                title: 'Mark Voted',
                subtitle: 'Record cast votes',
              ),
              const SizedBox(height: 24),
              Text(
                'Additional Options',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              _buildSimpleOptionCard(
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

  Widget _buildWardBoothDetails() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/ward.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Ward & Booth Details',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildInfoCard(
              icon: Icons.home,
              iconColor: Colors.blue,
              bgColor: const Color(0xFFE3F2FD),
              label: 'Ward',
              value: 'Ward 5', labelColor: Color(0xFF3A7BFE)
              , valueColor: Color(0xFF0A3D91)
              ,
            ),
            const SizedBox(height: 20),
            _buildInfoCard(
              icon: Icons.checkroom,
              iconColor: const Color(0xFF9C27B0),
              bgColor: const Color(0xFFF3E5F5),
              label: 'Booth Number',
              value: 'Booth 12', labelColor: Color(0xFF9B5CFF)
              , valueColor: Color(0xFF4B0082)
              ,
            ),
            const SizedBox(height: 20),
            _VoteCard(
              bgColor: const Color(0xFFE8F5E8),
              label: 'Voting Percentage',
              value: '0.00%', imagePath: 'assets/images/green.png',
            ),
            const SizedBox(height: 20),
            _VoteCard(
              bgColor: const Color(0xFFFFF3E0),
              label: 'Remaining Voters',
              value: '850', imagePath: 'assets/images/orange.png',
            ),
            const SizedBox(height: 20),
            _VoteCard(
              bgColor: const Color(0xFFE3F2FD),
              label: 'Total Voters',
              value: '850', imagePath: 'assets/images/blue.png',
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.access_time,
                      color: Colors.grey, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'Last updated: 27/11/2025, 12:52:33',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildInfoCard({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String label,
    required String value,
    required Color labelColor,   // NEW
    required Color valueColor,   // NEW
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: iconColor.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          // LEFT: Label + Value
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: labelColor, // updated
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: valueColor, // updated
                ),
              ),
            ],
          ),

          // RIGHT: Icon
          Icon(
            icon,
            color: iconColor,
            size: 22,
          ),
        ],
      ),
    );
  }



  Widget _VoteCard({
    required String imagePath,   // NEW → pass PNG instead of icon
    required Color bgColor,
    required String label,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 32,
            height: 32,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          // Right : PNG Image

        ],
      ),
    );
  }


  Widget _buildAssignedBoothSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2F5DFE),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.apartment_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Your Assigned Booth',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'You are managing Booth 12 in Ward 5',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Total Registered Voters: 850',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required Color iconBgColor,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey.shade400),
        ],
      ),
    );
  }

  Widget _buildSimpleOptionCard({
    required IconData icon,
    required String title,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade600, size: 22),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey.shade400),
        ],
      ),
    );
  }
}
