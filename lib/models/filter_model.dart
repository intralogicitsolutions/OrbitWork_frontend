import 'package:get/get.dart';

class FilterOption {
  final String title;
  final int count;
  final RxBool selected;

  FilterOption({required this.title, required this.count, bool isSelected = false})
      : selected = isSelected.obs;
}