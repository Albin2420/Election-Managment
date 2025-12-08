import 'dart:developer';
import 'package:election_management/src/data/model/votermodel.dart';
import 'package:election_management/src/data/model/voterstatus.dart';
import 'package:election_management/src/data/repositories/by_serial_number_repo_impl.dart/by_serial_number_repo_impl.dart';
import 'package:election_management/src/data/repositories/castvoter/cast_voter_repo_impl.dart';
import 'package:election_management/src/data/repositories/serialNumber/serial_number_repo_impl.dart';
import 'package:election_management/src/domain/repositories/byserialnumber/by_serial_number_repo.dart';
import 'package:election_management/src/domain/repositories/castvoter/cast_voter_repo.dart';
import 'package:election_management/src/domain/repositories/serialNumber/serial_number_repo.dart';
import 'package:election_management/src/presentation/screens/RemainingVoters/widgets/markvoted/voterdetailpage.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

class RemainingVoterController extends GetxController {
  SerialNumberRepo sr = SerialNumberRepoImpl();
  CastVoterRepo csr = CastVoterRepoImpl();
  BySerialNumberRepo rp = BySerialNumberRepoImpl();
  RxList<VoterModel> result = <VoterModel>[].obs;
  RxBool ourVotersOnly = false.obs;
  RxnInt remainingVoters = RxnInt();
  RxnString next = RxnString();
  RxnString previous = RxnString();
  RxString selectedRange = "".obs;
  final currentRange = ''.obs;
  final votedSerials = <String>[].obs;
  final RxList<VoterStatus> voterstatusvdata = <VoterStatus>[].obs;
  final RxList<VoterModel> voterbySerial = <VoterModel>[].obs;

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
          voterstatusvdata.value = (R['voter_status'] as List<dynamic>)
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

  Future<void> fetchVoter({required int serialNumber}) async {
    try {
      if (!EasyLoading.isShow) {
        final List<int> serialList = [serialNumber];
        EasyLoading.show();
        final res = await rp.getVotersbyserialNum(list: serialList);
        res.fold(
          (l) {
            EasyLoading.dismiss();
            serialList.clear();
          },
          (R) {
            voterbySerial.value = R['votersbySerial'] as List<VoterModel>;
            Get.to(() => VoterDetailsPage(currenTVoter: voterbySerial[0]));
            EasyLoading.dismiss();
            serialList.clear();
          },
        );
      }
    } catch (e) {
      log("⚠️ Error in fetchVoter():$e");
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: "$e");
    }
  }

  void toggleOurVoters() async {
    ourVotersOnly.value = !ourVotersOnly.value;
  }

  List<String> getSerialNumbersForRange() {
    final parts = currentRange.value.split('-');
    final start = int.parse(parts[0].trim());
    final end = int.parse(parts[1].trim());

    return [for (int i = start; i <= end; i++) i.toString().padLeft(3, '0')];
  }

  Future<void> markasVoted({required String id}) async {
    try {
      if (!EasyLoading.isShow) {
        EasyLoading.show();
        final res = await csr.markasCastVoter(list: [id]);
        res.fold(
          (l) {
            EasyLoading.dismiss();
          },
          (R) async {
            await jumpToRange(selectedRange.value);
            Get.back();
            EasyLoading.dismiss();
          },
        );
      }
    } catch (e) {
      EasyLoading.dismiss();
      log("⚠️ error in markasVoted():$e");
      Fluttertoast.showToast(msg: "something went wrong in mark voting");
    }
  }

  @override
  void onClose() {
    EasyLoading.dismiss();
    super.onClose();
  }
}
