import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/AddVoter/add_voter_controller.dart';

class PhotoUploadSection extends StatelessWidget {
  const PhotoUploadSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddVoterController>();

    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Obx(
                () => Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                border: Border.all(color: Colors.grey.shade300, width: 2),
                borderRadius: BorderRadius.circular(60),
              ),
              child: controller.selectedImage.value != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.file(
                  controller.selectedImage.value!,
                  fit: BoxFit.cover,
                ),
              )
                  : const Icon(
                Icons.camera_alt_outlined,
                size: 44,
                color: Colors.grey,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => controller.pickImage(),
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: const Color(0xFF2F5DFE),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2F5DFE).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
