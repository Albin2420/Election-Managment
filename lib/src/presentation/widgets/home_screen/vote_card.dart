import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VoteCard extends StatelessWidget {
  final String imagePath;
  final Color bgColor;
  final String label;
  final String value;
  final Color borderColor;
  final Color labelColor;
  final Color valueColor;

  const VoteCard({
    super.key,
    required this.imagePath,
    required this.bgColor,
    required this.label,
    required this.value,
    required this.borderColor,
    required this.labelColor,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border:
              Border.all(color: borderColor.withOpacity(0.5)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(imagePath,
                  width: 40, height: 40, fit: BoxFit.contain),
            ),
          ),

          const SizedBox(width: 20),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: labelColor,
                  )),
              const SizedBox(height: 2),
              Text(value,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: valueColor,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}