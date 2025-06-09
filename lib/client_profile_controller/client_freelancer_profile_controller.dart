
import 'package:get/get.dart';

class ClientFreelancerProfileController extends GetxController{
  var selectedWork = 'All work'.obs;

  var items = <GridItem>[
    GridItem(imagePath: 'assets/images/Teams_room.jpg', title: 'Amazon Listing Images'),
    GridItem(imagePath: 'assets/images/video-editing.jpg', title: 'Amazon EBC/A+ & Listing Images'),
    GridItem(imagePath: 'assets/images/voice-over.jpg', title: 'A+ Content'),
    GridItem(imagePath: 'assets/images/wordpress.jpg', title: 'Logo, Business Card, Thank You Card'),
  ].obs;

  void updateWork(String newWork) {
    selectedWork.value = newWork;
    Get.back();
  }
}

class GridItem {
  final String imagePath;
  final String title;

  GridItem({required this.imagePath, required this.title});
}
