import 'package:get/get.dart';
import '../models/job_model.dart';

class JobsController extends GetxController {
  var jobs = <Job>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchJobs();
  }

  void fetchJobs() {
    jobs.value = [
      Job(
        title: "Support on inside page User Interface Design",
        description: "Hi, we have one of our pages, which will function as an internal user ad.",
        postedTimeAgo: "1 hour",
        location: "India",
        budget: 300,
        paymentVerified: "Payment verified",
        rating: 5.0,
        tags: ["UI Design", "Interaction Design", "Figma"],
      ),
      Job(
        title: "Mobile App Development",
        description: "Looking for an expert in Flutter for a mobile app project.",
        postedTimeAgo: "2 hour",
        location: "USA",
        budget: 1000,
        paymentVerified: "Payment verified",
        rating: 4.8,
        tags: ["Flutter", "Dart", "Mobile Development"],
      ),
    ];
  }
}