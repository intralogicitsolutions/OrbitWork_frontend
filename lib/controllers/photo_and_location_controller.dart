import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../component/photo_upload_bottomsheet.dart';
import '../models/freelancer_profile_model.dart';
import '../models/photo_and_location_model.dart';
import '../routes/app_routes.dart';

class PhotoAndLocationController extends GetxController {
 // final profile = PhotoAndLocationModel().obs;

  final portfolio = Portfolio().obs;


  final ImagePicker imagePicker = ImagePicker();
  final formErrors = <String>[].obs;

  final currentImage = Rx<File?>(null);
  final zoomLevel = 1.0.obs;
  final isImageSelected = false.obs;
  final selectedImagePath = RxString('');

  final matrix = Matrix4.identity().obs;

  @override
  void onInit() {
    super.onInit();
    ever(zoomLevel, (_) {
      matrix.value = Matrix4.diagonal3Values(zoomLevel.value, zoomLevel.value, 1.0);
    });
  }

  void attachPhoto() {
    if (currentImage.value != null) {
      selectedImagePath.value = currentImage.value!.path;
      Get.back(); // Close the bottom sheet
    }
  }


  void updateZoomLevel(double value) {
    zoomLevel.value = value;
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      currentImage.value = File(image.path);
      selectedImagePath.value = image.path;
      isImageSelected.value = true;
      zoomLevel.value = 1.0;
    }
  }

  void deleteCurrentImage() {
    currentImage.value = null;
    selectedImagePath.value = '';
    isImageSelected.value = false;
    zoomLevel.value = 1.0;
    Get.back();
  }



  // void setDateOfBirth(DateTime date) {
  //   profile.update((val) {
  //     val?.dateOfBirth = date;
  //   });
  // }

  void setDateOfBirth(DateTime date) {
    portfolio.update((val) {
      val?.dob = date.toIso8601String();
    });
  }



  void setCountry(String country) {
    portfolio.update((val) {
      val?.city = country;
    });
  }

  void submitProfile() {
    // Implement your submit logic here
   // print(profile.value);
    Get.toNamed(AppRoutes.previewProfile);
  }

  // void setStreetAddress(String value) {
  //   profile.update((val) {
  //     val?.streetAddress = value;
  //   });
  //   validateStreetAddress();
  // }

  void setAptSuite(String value) {
    /*profile.update((val) {
      val?.aptSuite = value;
    });*/
  }

  // void setCity(String value) {
  //   profile.update((val) {
  //     val?.city = value;
  //   });
  //   validateCity();
  // }

  // void setStateProvince(String value) {
  //   profile.update((val) {
  //     val?.stateProvince = value;
  //   });
  // }

  // void setZipCode(String value) {
  //   profile.update((val) {
  //     val?.zipCode = value;
  //   });
  // }

  // void setPhoneNumber(String value) {
  //   profile.update((val) {
  //     val?.phoneNumber = value;
  //   });
  // }

  // void setPhoneCountryCode(String value) {
  //   profile.update((val) {
  //     val?.phoneCountryCode = value;
  //   });
  // }

  void validateStreetAddress() {
    if (portfolio.value.streetAddress?.isEmpty ?? true) {
      if (!formErrors.contains('street_address')) {
        formErrors.add('street_address');
      }
    } else {
      formErrors.remove('street_address');
    }
  }

  void validateCity() {
    if (portfolio.value.city?.isEmpty ?? true) {
      if (!formErrors.contains('city')) {
        formErrors.add('city');
      }
    } else {
      formErrors.remove('city');
    }
  }

  void showPhotoUploadSheet() {
    Get.bottomSheet(
       PhotoUploadSheet(),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

















  void setStreetAddress(String value) {
    portfolio.update((val) => val?.streetAddress = value);
    validateStreetAddress();
  }

  void setCity(String value) {
    portfolio.update((val) => val?.city = value);
    validateCity();
  }

  void setStateProvince(String value) {
    portfolio.update((val) => val?.state = value);
  }

  void setZipCode(String value) {
    portfolio.update((val) => val?.zip = value);
  }

  void setPhoneNumber(String value) {
    portfolio.update((val) => val?.phone = '+91 $value'); // Combine with country code
  }

  void setProfilePhoto(String url) {
    portfolio.update((val) => val?.profilePhoto = url);
  }

}