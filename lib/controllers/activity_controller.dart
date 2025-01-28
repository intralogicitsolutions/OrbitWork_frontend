import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/activity_model.dart';

class ActivityController extends GetxController {
  var activities = <ActivityModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchActivities();
  }

  void fetchActivities() async{
    await Future.delayed(Duration(seconds: 2));
    activities.value = [
      ActivityModel(
        title: "Your proposal was viewed",
        subtitle: "Your proposal for Full-Stack Developer was viewed.",
        date: "Jan 21",
        icon: Icons.visibility,
        iconColor: Colors.green,
      ),
      ActivityModel(
        title: "Weekly Summary Available",
        subtitle: "The work week has ended, and your weekly summary is ready.",
        date: "Jan 20",
        icon: Icons.calendar_today_outlined,
        iconColor: Colors.blue,
      ),
      ActivityModel(
        title: "Payment Received",
        subtitle: "Great news! You got paid early. Your balance is updated.",
        date: "Jan 17",
        icon: Icons.attach_money,
        iconColor: Colors.amber,
      ),
      ActivityModel(
        title: "No new notifications",
        subtitle: "You're all caught up for now!",
        date: "",
        icon: Icons.check_circle,
        iconColor: Colors.green,
      ),
    ];
    isLoading.value = false;
  }
}