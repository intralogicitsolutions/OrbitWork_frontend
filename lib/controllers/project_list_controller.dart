import 'package:get/get.dart';

class ProjectListController extends GetxController {
  final List<Map<String, String>> tipsList = [
    {
      'image': 'assets/images/online-teach.jpeg',
      'title': 'Use high-quality images or videos',
      'description': 'Show off your professional skills by adding work from your portfolio.',
    },
    {
      'image': 'assets/images/Teams_room.jpg',
      'title': 'Respond quickly to clients',
      'description': 'Clients can send questions before they buy. Try responding to these messages quickly so you\'re more likely to get an order.',
    },
    {
      'image': 'assets/images/freelancer.jpg',
      'title': 'Share with your social network',
      'description': 'Tell the world that you\'re open to new work. Send a link to anyone or share it directly on your social media feeds.',
    },
  ];

  final RxInt currentSlide = 0.obs;
  int get currentslide => currentSlide.value;
}