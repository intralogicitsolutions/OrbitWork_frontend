import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_contoller.dart';


class ZoomMeetingHelper {
  static Future<void> handleZoomMeetingCreation({
    required BuildContext context,
    required ChatController? chatController,
  }) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (selectedDate == null) return;

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime == null) return;

    final DateTime combinedDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    try {
      final joinUrl = await chatController?.createZoomMeetingAPI(combinedDateTime);
      print('joinUrl ==> $joinUrl');
      if (joinUrl != null) {
        chatController?.textController.text = joinUrl;
        chatController?.messageText.value = joinUrl;
        chatController?.selectedMeetingTime.value = combinedDateTime;
      } else {
        Get.snackbar('Error', 'Failed to create Zoom meeting');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed: $e');
    }
  }
}
