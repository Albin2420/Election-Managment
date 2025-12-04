import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MaintenancePage extends StatelessWidget {
  const MaintenancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/server.png',
                  height: 320, // Increased size from 250 → 320
                ),

                Text(
                  "Hang on!",
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    color: Colors.grey[500], // Changed to grey
                  ),
                ),
                Text(
                  "We are under maintenance",
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    color: Colors.grey[500],
                  ),
                ),
                const SizedBox(height: 60),

                // Retry Button
                SizedBox(
                  width: 160,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle retry action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF144AE9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      "Retry",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 24, // Larger font
                        fontWeight: FontWeight.w600, // Bolder
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
