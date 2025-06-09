
import 'package:get/get.dart';

class DisplaySettingController extends GetxController{
  var selectedType = 'Team'.obs;
  var selectedGroup = 'Day'.obs;
  var selectedColumn = 'Team'.obs;
  var columns = ['Team', 'Talent', 'Hours', 'Manual hours'];

  @override
  void onInit() {
    if (columns.isNotEmpty) {
      selectedColumn.value = columns.first;
    }
    super.onInit();
  }
}