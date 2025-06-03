import 'package:get/get.dart';

class ClientProfileController extends GetxController{
  var isOnline = true.obs;
  var isFavorite = false.obs;
  var selectedTab = 0.obs;

  void toggleOnlineStatus() {
    isOnline.value = !isOnline.value;
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }
}