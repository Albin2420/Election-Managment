import 'dart:developer';
import 'package:election_management/src/data/model/votercastmodel.dart';
import 'package:election_management/src/data/model/votermodel.dart';
import 'package:election_management/src/data/model/voterstatus.dart';
import 'package:election_management/src/data/repositories/by_serial_number_repo_impl.dart/by_serial_number_repo_impl.dart';
import 'package:election_management/src/data/repositories/castvoter/cast_voter_repo_impl.dart';
import 'package:election_management/src/data/repositories/serialNumber/serial_number_repo_impl.dart';
import 'package:election_management/src/domain/repositories/byserialnumber/by_serial_number_repo.dart';
import 'package:election_management/src/domain/repositories/castvoter/cast_voter_repo.dart';
import 'package:election_management/src/domain/repositories/serialNumber/serial_number_repo.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../screens/CastVotes/pageRoute/review_marked_voters_page.dart';

class CastVotesController extends GetxController {
  SerialNumberRepo sr = SerialNumberRepoImpl();
  BySerialNumberRepo byserialNumber = BySerialNumberRepoImpl();
  CastVoterRepo cst = CastVoterRepoImpl();

  final searchQuery = ''.obs;
  final searchResults = <VoterCastModel>[].obs;

  final castedVotes = <String>[].obs;
  final currentRange = ''.obs;

  final votedSerials = <String>[].obs;

  final List<VoterCastModel> allVoters = [];
  final RxList<VoterModel> voterbySerial = <VoterModel>[].obs;

  RxString selectedRange = "".obs;

  final RxList<VoterStatus> voterstatus = <VoterStatus>[].obs;

  void updateSearchQuery(String value) {
    searchQuery.value = value.trim();
  }

  List<String> getSerialNumbersForRange() {
    final parts = currentRange.value.split('-');
    final start = int.parse(parts[0].trim());
    final end = int.parse(parts[1].trim());

    return [for (int i = start; i <= end; i++) i.toString().padLeft(3, '0')];
  }

  void toggleSerialVote(String serial) {
    if (votedSerials.contains(serial)) {
      votedSerials.remove(serial);
    } else {
      votedSerials.add(serial);
    }
  }

  bool isSerialVoted(String serial) => votedSerials.contains(serial);

  int get markedCount => votedSerials.length;
  bool get hasMarkedVoters => votedSerials.isNotEmpty;

  Future<void> proceedToReview() async {
    try {
      if (votedSerials.isEmpty) {
        Fluttertoast.showToast(msg: "Please mark at least one voter");
        return;
      }

      EasyLoading.show();

      final List<int> serials = votedSerials
          .map((e) => int.parse(e.trim()))
          .toList();

      final res = await byserialNumber.getVotersbyserialNum(list: serials);

      res.fold(
        (L) {
          EasyLoading.dismiss();
          Fluttertoast.showToast(msg: "Something went wrong");
        },
        (R) {
          voterbySerial.value = R['votersbySerial'] as List<VoterModel>;

          EasyLoading.dismiss();
          Get.to(() => const ReviewMarkedVotersPage());
        },
      );
    } catch (e) {
      EasyLoading.dismiss();
      log("⚠️ Error in proceedToReview(): $e");
      Fluttertoast.showToast(msg: "Unexpected error occurred");
    }
  }

  void cancelAllMarkedVoters() {
    votedSerials.clear();
  }

  Future<void> confirmMarkedVoters() async {
    try {
      EasyLoading.show();
      final serialIds = voterbySerial.map((voter) => voter.id).toList();

      log("Confirmed as casted votes: $serialIds");

      final res = await cst.markasCastVoter(list: serialIds);
      res.fold(
        (l) {
          Fluttertoast.showToast(msg: "something went wrong");
          EasyLoading.dismiss();
        },
        (R) {
          EasyLoading.dismiss();
          votedSerials.clear();
          voterbySerial.clear();
          Get.back();
        },
      );
    } catch (e) {
      log("Error confirming voters: $e");
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: "something went wrong:e-103");
    }
  }

  Future<void> jumpToRange(String range) async {
    try {
      selectedRange.value = range;
      final parts = range.split('-');

      final start = int.tryParse(parts[0].trim());
      final end = int.tryParse(parts[1].trim());

      if (start != null && end != null) {
        EasyLoading.show();
        final res = await sr.getBySerialnumber(start: start, end: end);
        res.fold((l) => EasyLoading.dismiss(), (R) {
          currentRange.value = range;
          voterstatus.value = (R['voter_status'] as List<dynamic>)
              .map((e) => e as VoterStatus)
              .toList();
          EasyLoading.dismiss();
        });
      } else {
        log("❌ Invalid Range Format");
        EasyLoading.dismiss();
      }
    } catch (e) {
      log("⚠️ Error in jumpToRange():$e");
      EasyLoading.dismiss();
    }
  }
}
