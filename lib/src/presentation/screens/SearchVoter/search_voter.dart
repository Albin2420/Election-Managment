import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/SearchVoter/search_voter_controller.dart';
import '../../widgets/MarkVoter/go_home_button.dart';
import '../../widgets/Search_Voter/empty_state.dart';
import '../../widgets/Search_Voter/search_box.dart';
import '../../widgets/Search_Voter/search_header.dart';
import '../../widgets/Search_Voter/search_result_list.dart';

class SearchVoterPage extends StatelessWidget {
  const SearchVoterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchVoterController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          const SearchVoterHeader(),
          const SearchBox(),
          Expanded(
            child: Obx(() {
              if (controller.searchQuery.isEmpty) {
                return const EmptyStateWidget();
              }
              return const SearchResultList();
            }),
          ),
          const GoHomeButton(),
        ],
      ),
    );
  }
}
