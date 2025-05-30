import 'package:get/get.dart';

class TeamController extends GetxController{
  var selectedIndex = 0.obs;
  final tabTitles = ['Teams', 'Members', 'Invitations'];
  void changeTab(int index) {
    selectedIndex.value = index;
  }
  String get currentTitle => tabTitles[selectedIndex.value];
}