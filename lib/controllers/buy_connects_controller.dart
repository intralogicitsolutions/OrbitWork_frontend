import 'package:get/get.dart';

import '../routes/app_routes.dart';

class BuyConnectsController extends GetxController{
  final showWarning = true.obs;
  final RxString selectConnects = '100 for \$15.00'.obs;
  final isBottomSheetOpen = false.obs;
  var hasBoughtConnects = false.obs;

  void dismissWarningText(){
    showWarning.value = false;
  }

  void setNUmberOfConnects(String value){
    selectConnects.value = value;
    Get.back();
  }

  void closeBothAndNavigateBack(){
    if(isBottomSheetOpen.value){
      Get.back();
      Get.back();
      isBottomSheetOpen.value = false;
    }
    Get.back();
  }

  bool handleBackPress(){
    if(isBottomSheetOpen.value){
        closeBothAndNavigateBack();
        return false;
    }
    return true;
  }

  void buyConnects() {
    hasBoughtConnects.value = true;
    Get.back();
  }
}