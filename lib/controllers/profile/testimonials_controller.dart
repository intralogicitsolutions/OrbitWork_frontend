import 'package:get/get.dart';

class TestimonialController extends GetxController {
  final firstName = ''.obs;
  final lastName = ''.obs;
  final businessEmail = ''.obs;
  final linkedInProfile = ''.obs;
  final clientTitle = ''.obs;
  final projectType = ''.obs;
  final messageToClient = ''.obs;

  void resetForm() {
    firstName.value = '';
    lastName.value = '';
    businessEmail.value = '';
    linkedInProfile.value = '';
    clientTitle.value = '';
    projectType.value = '';
    messageToClient.value = '';
  }
}