import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_contoller.dart';


class ZoomMeetingHelper {
  static Future<void> handleZoomMeetingCreation({
    required BuildContext context,
    required ChatController? chatController,
  }) async {
    final ThemeData datePickerTheme = ThemeData(
      colorScheme: ColorScheme.light(
        primary: Colors.green, // header background & selected date
        onPrimary: Colors.white, // text color on selected date
        onSurface: Colors.black, // default text color
      ),
      dialogBackgroundColor: Colors.white,
    );
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child){
        return Theme(data: datePickerTheme, child: child!);
      }
    );

    if (selectedDate == null) return;

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child){
        return Theme(data: ThemeData(
          colorScheme: ColorScheme.light(
            primary: Colors.green,
            onPrimary: Colors.white,
            onSurface: Colors.black,
          ),
          timePickerTheme: TimePickerThemeData(
            backgroundColor: Colors.white,
            hourMinuteTextColor: Colors.green,
            hourMinuteColor: Colors.green.shade50,
           // dialHandColor: Colors.green,
           dialBackgroundColor: Colors.green.shade50,
            entryModeIconColor: Colors.green,
            dayPeriodColor: Colors.green.shade50,
            helpTextStyle: TextStyle(color: Colors.green)
          )
        ),
            child: child!);
      }
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
