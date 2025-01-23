import 'package:get/get.dart';
import '../models/alerts_model.dart';

class AlertsController extends GetxController {
  var alerts = <AlertModel>[].obs;
  var selectedTab = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAlerts();
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void fetchAlerts() {
    alerts.value = [
      AlertModel(
        title: "Your proposal was viewed",
        description: "Your proposal for Full-Stack Developer was viewed.",
        date: "Jan 21",
      ),
      AlertModel(
        title: "Weekly Summary Available",
        description: "The work week has ended, and your summary is ready.",
        date: "Jan 20",
      ),
      AlertModel(
        title: "Payment Received",
        description: "You got paid early! Your available balance is updated.",
        date: "Jan 17",
      ),
    ];
  }
}