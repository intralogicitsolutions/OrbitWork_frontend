import 'package:get/get.dart';

class ClientAgencyProfileController extends GetxController{
  var isExpanded = false.obs;
  var businessExpanded = false.obs;

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }

  void toggleBusinessExpanded(){
    businessExpanded.value = !businessExpanded.value;
  }
}