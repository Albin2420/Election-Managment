import 'dart:convert';
import 'dart:developer';
import 'package:election_management/src/data/repositories/new_voter/new_voter_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../domain/repositories/new_voter/new_voter_repo.dart';

class AddVoterController extends GetxController {
  final NewVoterRepo _newVoterRepo = NewVoterRepoImpl();

  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final serialNumberController = TextEditingController();
  final houseNumberController = TextEditingController();
  final electoralIdController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  RxString gender = RxString("");
  final ageController = TextEditingController();

  final selectedImage = Rx<File?>(null);
  final imagePicker = ImagePicker();

  Future<void> pickImage() async {
    try {
      final XFile? image = await imagePicker.pickImage(
        source: ImageSource.camera,
      );
      if (image != null) {
        selectedImage.value = File(image.path);
      }
    } catch (e) {
      log("⚠️ Error in pickImage():$e");
    }
  }

  Future<void> addVoter() async {
    if (formKey.currentState!.validate()) {
      try {
        var voterdata = jsonEncode({
          "name": fullNameController.text,
          "serial_number": int.parse(serialNumberController.text.toString()),
          "age": int.parse(ageController.text.toString()),
          "gender": gender.value,
          "address": addressController.text.toString(),
          "ward_number": 20,
          "house_number": int.parse(houseNumberController.text.toString()),
          "is_active": true,
          "is_alive": true,
          "is_disputed": true,
        });

        EasyLoading.show();
        final res = await _newVoterRepo.createNewvoter(newVoter: voterdata);
        res.fold(
          (l) {
            EasyLoading.dismiss();
          },
          (R) {
            EasyLoading.dismiss();
            Fluttertoast.showToast(msg: "voters addedd successfully");
            clearForm();
          },
        );
      } catch (e) {
        log("⚠️ Error in addVoter():$e");
      }
    }
  }

  void clearForm() {
    formKey.currentState!.reset();
    fullNameController.clear();
    serialNumberController.clear();
    houseNumberController.clear();
    electoralIdController.clear();
    phoneNumberController.clear();
    addressController.clear();
    ageController.clear();
    selectedImage.value = null;
    gender.value = '';
  }

  void goToHome() {
    Get.offNamed('/home');
  }

  @override
  void onClose() {
    fullNameController.dispose();
    serialNumberController.dispose();
    houseNumberController.dispose();
    electoralIdController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    ageController.dispose();
    super.onClose();
  }
}
