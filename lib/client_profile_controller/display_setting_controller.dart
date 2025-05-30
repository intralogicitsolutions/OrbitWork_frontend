
import 'package:get/get.dart';

class DisplaySettingController extends GetxController{
  var selectedType = 'Team'.obs;
  var selectedGroup = 'Day'.obs;
  var selectedColumn = 'Column 1'.obs;
  var columns = ['Team', 'Talent', 'Hours', 'Manual hours'];
}