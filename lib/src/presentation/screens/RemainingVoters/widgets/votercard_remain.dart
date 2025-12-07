import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VoterCard extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final String serial;
  final String house;
  final String id;

  final bool ourVoter;
  final bool voted; // 👉 NEW FIELD

  const VoterCard({
    super.key,
    required this.name,
    this.imageUrl,
    required this.serial,
    required this.house,
    required this.id,
    this.ourVoter = false,
    this.voted = false, // 👉 NEW
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ------------------ IMAGE ------------------ //
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: (imageUrl != null && imageUrl!.isNotEmpty)
                    ? Image.network(
                        imageUrl!,
                        height: 68,
                        width: 68,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 68,
                        width: 68,
                        color: Colors.grey.shade200,
                        child: const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
              ),

              // small green tick on image
              if (ourVoter)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(width: 12),

          // ------------------ RIGHT SECTION ------------------ //
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Name
                    Expanded(
                      child: Text(
                        name,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    // Our Voter Badge
                    if (ourVoter)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "Our Voter",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.green.shade800,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                    const SizedBox(width: 6),
                  ],
                ),

                const SizedBox(height: 6),

                _infoRow(Icons.tag, "Serial: $serial"),
                _infoRow(Icons.house_outlined, "House: $house"),
                _infoRow(Icons.location_on_outlined, "ID: $id"),
                const SizedBox(height: 6),

                // ------------------ Voted Badge ------------------ //
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: voted ? Colors.green.shade100 : Colors.red.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    voted ? "Voted" : "Not Voted",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: voted
                          ? Colors.green.shade800
                          : Colors.red.shade800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  // Reusable Row Widget
  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[700]),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }
}
