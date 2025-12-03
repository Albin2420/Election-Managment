import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoCardStatic extends StatelessWidget {
  final String imageName;
  final String tag;
  final Color bgColor;
  final String label;
  final String value;
  final Color labelColor;
  final Color valueColor;
  final Color borderBaseColor;

  const InfoCardStatic({
    super.key,
    required this.imageName,
    required this.tag,
    required this.bgColor,
    required this.label,
    required this.value,
    required this.labelColor,
    required this.valueColor,
    required this.borderBaseColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color borderColor = Color.lerp(borderBaseColor, Colors.black, 0.05)!;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$label - $value",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: labelColor,
                  ),
                ),
                const SizedBox(height: 2),

                /// Static (non-scrollable) version of tag
                Text(
                  tag,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: valueColor,
                  ),
                ),
              ],
            ),
          ),

          Image.asset(imageName, width: 55, height: 55),
        ],
      ),
    );
  }
}
