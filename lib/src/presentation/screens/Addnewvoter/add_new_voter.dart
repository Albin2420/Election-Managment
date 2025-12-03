import 'package:election_management/src/presentation/widgets/go_home_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/AddVoter/add_voter_controller.dart';
import '../../widgets/NewVoter/add_voter_button.dart';
import '../../widgets/NewVoter/address_field.dart';
import '../../widgets/NewVoter/new_voter_header.dart';
import '../../widgets/NewVoter/photo_upload_section.dart';
import '../../widgets/NewVoter/text_input_field.dart';

class AddNewVoterScreen extends StatelessWidget {
  const AddNewVoterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddVoterController());

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
                    key: controller.formKey,
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
                          controller: controller.fullNameController,
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Gender',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF1F2937),
                              ),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              value: controller.gender.isEmpty
                                  ? null
                                  : controller.gender.value,
                              items: ['male', 'female', 'other ']
                                  .map(
                                    (gender) => DropdownMenuItem(
                                      value: gender,
                                      child: Text(gender),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                controller.gender.value = value ?? '';
                              },
                              decoration: InputDecoration(
                                hintText: 'Select gender',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade50,
                                ),
                                // Grey border before tapping/focus
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE5E7EB),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE5E7EB),
                                  ), // Grey when idle
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF2F5DFE),
                                  ), // Blue when focused
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                              validator: (value) =>
                                  (value == null || value.isEmpty)
                                  ? 'Please select gender'
                                  : null,
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),
                        TextInputField(
                          label: 'Age',
                          hint: 'Enter age',
                          keyboard: TextInputType.number,
                          controller: controller.ageController,
                        ),

                        const SizedBox(height: 20),
                        TextInputField(
                          label: 'Serial Number',
                          hint: 'Enter serial number',
                          controller: controller.serialNumberController,
                          keyboard: TextInputType.number,
                        ),
                        const SizedBox(height: 20),
                        TextInputField(
                          label: 'House Number',
                          hint: 'Enter house number',
                          controller: controller.houseNumberController,
                        ),
                        const SizedBox(height: 20),
                        TextInputField(
                          label: 'Electoral ID',
                          hint: 'Enter electoral ID',
                          controller: controller.electoralIdController,
                        ),
                        const SizedBox(height: 20),
                        TextInputField(
                          label: 'Phone Number',
                          hint: 'Enter phone number',
                          keyboard: TextInputType.phone,
                          controller: controller.phoneNumberController,
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
              GoHomeButton(
                onTap: () {
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
