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
      final XFile? image =
      await imagePicker.pickImage(source: ImageSource.camera);
      if (image != null) {
        selectedImage.value = File(image.path);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error picking image: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void addVoter() {
    if (formKey.currentState!.validate()) {
      if (selectedImage.value == null) {
        Get.snackbar(
          'Error',
          'Please upload voter photo',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // Handle add voter logic here
      // You can send the data to your API or database
      final voterData = {
        'fullName': fullNameController.text,
        'serialNumber': serialNumberController.text,
        'houseNumber': houseNumberController.text,
        'electoralId': electoralIdController.text,
        'phoneNumber': phoneNumberController.text,
        'address': addressController.text,
        'photo': selectedImage.value!.path,
      };

      Get.snackbar(
        'Success',
        'Voter added successfully',
        snackPosition: SnackPosition.BOTTOM,
      );

      // Clear form after submission
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