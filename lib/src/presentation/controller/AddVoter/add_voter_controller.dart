import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddVoterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final serialNumberController = TextEditingController();
  final houseNumberController = TextEditingController();
  final electoralIdController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();

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
      log("error");
    }
  }

  void addVoter() {
    if (formKey.currentState!.validate()) {
      if (selectedImage.value == null) {
        log("please upload voter photo");
        return;
      }

      final voterData = {
        'fullName': fullNameController.text,
        'serialNumber': serialNumberController.text,
        'houseNumber': houseNumberController.text,
        'electoralId': electoralIdController.text,
        'phoneNumber': phoneNumberController.text,
        'address': addressController.text,
        'photo': selectedImage.value!.path,
      };

      log("success,voter added successfully");

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
    super.onClose();
  }
}
