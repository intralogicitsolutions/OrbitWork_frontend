import 'package:get/get.dart';

class JobTitleController extends GetxController{
  var title = ''.obs;
  var errors = <String>[].obs;

  final exampleTitles = [
    "Build responsive WordPress site with booking/payment functionality",
    "Graphic designer needed to design ad creative for multiple campaigns",
    "Facebook ad specialist needed for product launch",
  ].obs;

  void validateTitle(String value) {
    title.value = value;
    errors.clear();

    if (value.isEmpty) {
      errors.add(' Title is required');
    } else {
      if (value.length <= 3) {
        errors.add(' Must be more than 3 characters');
      }
      if (value == value.toUpperCase()) {
        errors.add(' Title should not be all uppercase letters');
      }
    }
  }
}