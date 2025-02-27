import 'package:get/get.dart';

class ProfilePageController extends GetxController{
  final RxInt currentTabIndex = 0.obs;

  var selectedWork = 'All Work'.obs;
  var showDraft = false.obs;
  var isPublished = false.obs;

  var draftStatus = {
    "Mobile App Development": true,
    "Creative Writing": true,
    "All Work": false,
  }.obs;

  void changeTab(int index) {
    currentTabIndex.value = index;
  }


  // void setSelectedWork(String work) {
  //   selectedWork.value = work;
  //  // showDraft.value = (work != 'All Work'); // Show draft only if not 'All Work'
  //   if (!isPublished.value) {
  //     showDraft.value = (work != 'All Work'); // Show draft if not published
  //   }
  // }
  void setSelectedWork(String work) {
    selectedWork.value = work;
    Get.back(); // Close bottom sheet after selection
  }

  // void publishProfile() {
  //   showDraft.value = false; // Hide draft after publishing
  //   isPublished.value = true;
  // }
  void publishProfile() {
    String work = selectedWork.value;
    draftStatus[work] = false; // Remove draft only for the selected work
    draftStatus.refresh(); // Refresh UI
  }
}