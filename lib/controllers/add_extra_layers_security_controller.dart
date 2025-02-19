import 'package:get/get.dart';

class AddExtraLayersSecurityController extends GetxController{
  var showPassword = false.obs;
  var isLocked = false.obs;
  var isLogged = false.obs;

  final selectedSecurityQuestion = ''.obs;
  final filterSecurityQuestion = <String>[].obs;

  final securityQuestion = [
    'Your mother\'s maiden name', 'Your first pet\'s name', 'The name of your elementary school',
    'Your elementary school mascot', 'Your best friend\'s nickname', 'Your favorite sports team'
  ];

  @override
  void onInit() {
    super.onInit();
    filterSecurityQuestion.value = securityQuestion;
  }

  void updateCountry(String securityQuestion) {
    selectedSecurityQuestion.value = securityQuestion;
    Get.back();
  }

}