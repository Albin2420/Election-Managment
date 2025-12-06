import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/MarkVoter/mark_voter_controller.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MarkVoterController>();
    final TextEditingController textController = TextEditingController();

    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black54.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: SizedBox(
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade400, width: 1),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: textController,
                onChanged: (value) {
                  controller.searchVoters(value);
                },
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 7, right: 7),
                    child: Icon(
                      Icons.search,
                      size: 24,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 0,
                    minHeight: 0,
                  ),
                  suffixIcon: Obx(() {
                    return controller.searchQuery.value.isNotEmpty
                        ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        size: 20,
                        color: Colors.grey.shade600,
                      ),
                      onPressed: () {
                        textController.clear();
                        controller.clearSearch();
                      },
                    )
                        : const SizedBox.shrink();
                  }),
                  hintText: "Search by name, house number",
                  hintStyle: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade400,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}