import 'dart:convert';
import 'dart:developer';
import 'package:election_management/src/data/repositories/new_voter/new_voter_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../domain/repositories/new_voter/new_voter_repo.dart';

class AddVoterController extends GetxController {
  NewVoterRepo _newVoterRepo = NewVoterRepoImpl();

  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final serialNumberController = TextEditingController();
  final houseNumberController = TextEditingController();
  final electoralIdController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  final genderController = TextEditingController();
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
      if (selectedImage.value == null) {
        return;
      }

      //       final voterData = jsonEncode({
      //         'name': fullNameController.text,
      //         'serial_number': serialNumberController.text,
      //         'house_number': houseNumberController.text,
      //         'electoralId': electoralIdController.text,
      //         'phoneNumber': phoneNumberController.text,
      //         'address': addressController.text,
      //         'photo': selectedImage.value!.path,

      //         'is_active': true,
      //         'is_alive': true,
      //         'is_disputed': true,
      //         'lsg_booth':
      //       });

      //       //**
      //       //{
      //   "name": "string",
      //   "guardian_name": "string", --nop//
      //   "age": 2147483647,//n
      //   "gender": "male",//n
      //   "address": "string",
      //   "photo": "string",
      //   "serial_number": 2147483647,
      //   "ward_number": 2147483647,
      //   "house_number": 2147483647,
      //   "sec_id_number": "string",
      //   "is_active": true,
      //   "inactive_reason": "string",
      //   "is_alive": true,
      //   "is_disputed": true,
      //   "lsg_booth": "3fa85f64-5717-4562-b3fc-2c963f66afa6"
      // }
      //
      //
      //
      //
      // */

      final res = await _newVoterRepo.createNewvoter(newVoter: {});
      res.fold((l) {}, (R) {});

      clearForm();
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
    genderController.clear();
    ageController.clear();
    selectedImage.value = null;
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
    genderController.dispose();
    ageController.dispose();
    super.onClose();
  }
}
