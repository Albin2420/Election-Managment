import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/SearchVoter/search_voter_controller.dart';

class SearchResultList extends StatelessWidget {
  const SearchResultList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SearchVoterController>();

    return ListView.builder(
      itemCount: controller.searchResults.length,
      itemBuilder: (context, index) {
        final voter = controller.searchResults[index];

        return ListTile(
          title: Text(voter.name),
          subtitle: Text("House No: ${voter.houseNumber}"),
          trailing: Icon(
            voter.isSearched ? Icons.check_circle : Icons.circle_outlined,
            color: voter.isSearched ? Colors.green : Colors.grey,
          ),
          onTap: () {
            voter.isSearched
                ? controller.unsearchVoter(voter.id)
                : controller.searchVoterAsSearched(voter.id);
          },
        );
      },
    );
  }
}
