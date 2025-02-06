import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/photo_and_location_controller.dart';
import '../../routes/app_routes.dart';

class PhotoAndLocation extends GetView<PhotoAndLocationController> {
  final PhotoAndLocationController controller =
      Get.put(PhotoAndLocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Your Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'A few last details, then you\ncan check and publish your\nprofile.',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'A professional photo helps you build trust with your clients. To keep things safe and simple, they\'ll pay you through us - which is why we need your personal information.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: Column(
                        children: [
                          // Obx(() => CircleAvatar(
                          //       radius: 50,
                          //       backgroundColor: Colors.grey[200],
                          //       backgroundImage:
                          //           controller.profile.value.photoUrl != null
                          //               ? FileImage(File(
                          //                   controller.profile.value.photoUrl!))
                          //               : null,
                          //       child: controller.profile.value.photoUrl == null
                          //           ? const Icon(Icons.person, size: 50)
                          //           : null,
                          //     )),
                          Obx(() => CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[200],
                            backgroundImage: controller.selectedImagePath.isNotEmpty
                                ? FileImage(File(controller.selectedImagePath.value))
                                : null,
                            child: controller.selectedImagePath.isEmpty
                                ? const Icon(Icons.person, size: 50, color: Colors.grey)
                                : ClipOval(
                              child: Transform(
                                transform: controller.matrix.value,
                                alignment: Alignment.center,
                                child: Image.file(
                                  File(controller.selectedImagePath.value),
                                  fit: BoxFit.cover,
                                  width: 100, // 2x radius
                                  height: 100,
                                ),
                              ),
                            ),
                          )),
                          const SizedBox(height: 16),
                          OutlinedButton.icon(
                            onPressed: controller.showPhotoUploadSheet,
                            icon: const Icon(Icons.add, color: Colors.green,),
                            label:  Text(controller.isImageSelected.value ? 'Change photo' : 'Upload photo'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.green,
                              side: const BorderSide(color: Colors.green,width: 2 ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Date of Birth *',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          controller.setDateOfBirth(picked);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today),
                            const SizedBox(width: 8),
                            Obx(() => Text(
                                  controller.profile.value.dateOfBirth
                                          ?.toString()
                                          .split(' ')[0] ??
                                      'yyyy-mm-dd',
                                )),
                            const Spacer(),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Country *',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      onChanged: controller.setCountry,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: 'Select your country',
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildAddressSection(),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey, width: 0.5),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.green),
                  onPressed: () => Get.back(),
                ),
                ElevatedButton(
                  onPressed: controller.submitProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Review your profile',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(
          label: 'Street address *',
          hintText: 'Enter street address',
          onChanged: controller.setStreetAddress,
          errorText: 'Fill in your street address',
          showError: controller.formErrors.contains('street_address'),
        ),
        const SizedBox(height: 16),
        _buildTextField(
          label: 'Apt/Suite',
          hintText: 'Apt/Suite (Optional)',
          onChanged: controller.setAptSuite,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                label: 'City *',
                hintText: 'Enter city',
                onChanged: controller.setCity,
                errorText: 'Add your city',
                showError: controller.formErrors.contains('city'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                label: 'State/Province',
                hintText: 'Enter state/provinc',
                onChanged: controller.setStateProvince,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildTextField(
          label: 'ZIP/Postal code',
          hintText: 'Enter ZIP/Postal',
          onChanged: controller.setZipCode,
        ),
        const SizedBox(height: 16),
        _buildPhoneField(),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String hintText,
    required Function(String) onChanged,
    String? errorText,
    bool showError = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
        ),
        if (showError && errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 16),
                const SizedBox(width: 4),
                Text(
                  errorText,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Phone *',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                width: 100,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    // Implement country code picker
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: [
                        Image.asset('assets/icon/flag-india.png',
                            width: 24, height: 16),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  onChanged: controller.setPhoneNumber,
                  decoration: const InputDecoration(
                    hintText: 'Enter number',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    prefixText: '+91 ',
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
