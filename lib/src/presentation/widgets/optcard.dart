import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Optcard extends StatelessWidget {
  final VoidCallback onTap;
  final String iconImage;
  final String title;
  final Color? bgColor; // optional

  const Optcard({
    super.key,
    required this.iconImage,
    required this.title,
    required this.onTap,
    this.bgColor, // optional
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color:
              bgColor ??
              const Color(0xFFF8FAFB), // use passed color else default
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Image.asset(iconImage, height: 42, width: 42, fit: BoxFit.contain),

            const SizedBox(width: 16),

            Expanded(
              child: Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF0C1A30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
