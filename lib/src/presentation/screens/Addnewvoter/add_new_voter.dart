import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/AddVoter/add_voter_controller.dart';
import '../../widgets/NewVoter/add_voter_button.dart';
import '../../widgets/NewVoter/address_field.dart';
import '../../widgets/NewVoter/go_home_button.dart';
import '../../widgets/NewVoter/new_voter_header.dart';
import '../../widgets/NewVoter/photo_upload_section.dart';
import '../../widgets/NewVoter/text_input_field.dart';

class AddNewVoterScreen extends StatelessWidget {
  const AddNewVoterScreen({super.key});

  @override
  Widget build(BuildContext context) {
  Get.put(AddVoterController());

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const NewVoterHeader(),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 30,
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Form(
                    key: Get.find<AddVoterController>().formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        const PhotoUploadSection(),
                        const SizedBox(height: 14),

                        Text(
                          'Upload voter photo',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 32),
                        TextInputField(
                          label: 'Full Name',
                          hint: 'Enter full name',
                          controller: Get.find<AddVoterController>().fullNameController,
                        ),

                        const SizedBox(height: 20),
                        TextInputField(
                          label: 'Serial Number',
                          hint: 'Enter serial number',
                          controller: Get.find<AddVoterController>().serialNumberController,
                        ),

                        const SizedBox(height: 20),
                        TextInputField(
                          label: 'House Number',
                          hint: 'Enter house number',
                          controller: Get.find<AddVoterController>().houseNumberController,
                        ),

                        const SizedBox(height: 20),
                        TextInputField(
                          label: 'Electoral ID',
                          hint: 'Enter electoral ID',
                          controller: Get.find<AddVoterController>().electoralIdController,
                        ),

                        const SizedBox(height: 20),
                        TextInputField(
                          label: 'Phone Number',
                          hint: 'Enter phone number',
                          controller: Get.find<AddVoterController>().phoneNumberController,
                          keyboard: TextInputType.phone,
                        ),

                        const SizedBox(height: 20),
                        const AddressField(),
                        const SizedBox(height: 32),
                        const AddVoterButton(),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
              const GoHomeButton(),
            ],
          ),
        ),
      ),
    );
  }
}
