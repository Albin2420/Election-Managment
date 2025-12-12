// import 'dart:developer';
// import 'package:election_management/src/presentation/controller/RemainingVoterController/remaining_voter_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// class SerialNumberWidget extends StatelessWidget {
//   const SerialNumberWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<RemainingVoterController>();

//     return Obx(() {
//       final range = controller.currentRange.value;

//       if (range.isEmpty) {
//         return const SizedBox.shrink();
//       }

//       return Container(
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.08),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Serial Numbers $range",
//               style: GoogleFonts.inter(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             const SizedBox(height: 12),

//             Wrap(
//               spacing: 12,
//               runSpacing: 12,
//               children: controller.getSerialNumbersForRange().map((serial) {
//                 return Obx(() {
//                   final voter = controller.voterstatusvdata.firstWhereOrNull(
//                     (v) => v.serialNumber == int.tryParse(serial),
//                   );

//                   final hasVoted = voter?.hasVoted ?? false;

//                   return GestureDetector(
//                     onTap: () {
//                       if (voter != null && voter.hasVoted == false) {
//                         controller.fetchVoter(serialNumber: voter.serialNumber);
//                       } else {
//                         if (voter == null) {
//                           Fluttertoast.showToast(msg: "something went wrong");
//                         } else {
//                           Fluttertoast.showToast(msg: "marked as voted.");
//                         }
//                       }
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 10,
//                       ),
//                       decoration: BoxDecoration(
//                         color: hasVoted ? Colors.grey.shade300 : Colors.white,
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(
//                           color: hasVoted
//                               ? Colors.grey.shade400
//                               : Colors.grey.shade300,
//                         ),
//                       ),
//                       child: Text(
//                         serial,
//                         style: GoogleFonts.inter(
//                           fontSize: 13,
//                           color: hasVoted
//                               ? Colors.grey.shade600
//                               : Colors.black87,
//                         ),
//                       ),
//                     ),
//                   );
//                 });
//               }).toList(),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }

import 'package:election_management/src/presentation/controller/RemainingVoterController/remaining_voter_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SerialNumberWidget extends StatelessWidget {
  const SerialNumberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RemainingVoterController>();

    return Obx(() {
      final range = controller.currentRange.value;

      if (range.isEmpty) {
        return const SizedBox.shrink();
      }

      // Fetch all serials for the selected range
      final serials = controller.getSerialNumbersForRange();

      // Apply filter only if "Our Voters" is ON
      final filteredSerials = controller.ourVotersOnly.value
          ? serials.where((serial) {
              final v = controller.voterstatusvdata.firstWhereOrNull(
                (x) => x.serialNumber == int.tryParse(serial),
              );
              return v?.isOurvoter == true; // Only our voters.
            }).toList()
          : serials;

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.ourVotersOnly.value
                  ? "Serial Numbers (Our Voters)"
                  : "Serial Numbers $range",
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            if (filteredSerials.isEmpty)
              const Text("No voters found in this range"),

            if (filteredSerials.isNotEmpty)
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: filteredSerials.map((serial) {
                  return Obx(() {
                    final voter = controller.voterstatusvdata.firstWhereOrNull(
                      (v) => v.serialNumber == int.tryParse(serial),
                    );

                    final hasVoted = voter?.hasVoted ?? false;

                    return GestureDetector(
                      onTap: () {
                        if (voter != null && !voter.hasVoted) {
                          controller.fetchVoter(
                            serialNumber: voter.serialNumber,
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: voter == null
                                ? "Something went wrong"
                                : "Already voted",
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: hasVoted ? Colors.grey.shade300 : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: hasVoted
                                ? Colors.grey.shade400
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Text(
                          serial,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: hasVoted
                                ? Colors.grey.shade600
                                : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  });
                }).toList(),
              ),
          ],
        ),
      );
    });
  }
}
