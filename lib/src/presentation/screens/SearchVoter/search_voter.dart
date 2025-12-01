import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/SearchVoter/search_voter_controller.dart';
import '../../widgets/NewVoter/go_home_button.dart';
import '../../widgets/Search_Voter/empty_state.dart';
import '../../widgets/Search_Voter/no_results_widget.dart';
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
              print("Search Query: '${controller.searchQuery.value}'");
              print("Search Results Count: ${controller.searchResults.length}");
              print("Has Searched: ${controller.hasSearched}");
              print("Has Results: ${controller.hasResults}");

              // Show empty state when no search has been performed
              if (controller.searchQuery.value.isEmpty) {
                return const EmptyStateWidget();
              }

              // Show no results when search performed but no matches
              if (controller.searchQuery.value.isNotEmpty &&
                  controller.searchResults.isEmpty) {
                return const NoResultsWidget();
              }

              // Show results when there are matches
              return const SearchResultList();
            }),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GoHomeButton(
            onTap: () {
              Get.back();
            },
          ),
        ],
      )),
    );
  }
}