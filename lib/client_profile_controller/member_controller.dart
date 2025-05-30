import 'package:get/get.dart';

class MembersController extends GetxController{
  RxBool isAuthorized = false.obs;
  var selectedTeam = 'All teams'.obs;
  var searchText = ''.obs;

  final List<String> teams = [
    'All teams',
    'Development Team',
    'Design Team',
    'Marketing Team'
  ];

  void authorizeUser() {
    isAuthorized.value = true;
  }

  void updateSelectedTeam(String team) {
    selectedTeam.value = team;
  }

  void updateSearchText(String text) {
    searchText.value = text;
  }
}