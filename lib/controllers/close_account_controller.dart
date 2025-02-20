import 'package:get/get.dart';

class CloseAccountController extends GetxController{

  final RxString selectReason = ''.obs;

  void setReason(String value){
    selectReason.value = value;
  }
}