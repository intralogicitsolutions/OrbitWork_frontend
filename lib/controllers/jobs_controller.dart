import 'package:get/get.dart';
import '../models/job_model.dart';

class JobsController extends GetxController {
  var jobs = <Job>[].obs;
  var favoriteJobs = <Job>[].obs;
  var selectedReason = "".obs;
  var selectedReasons = <Job, String>{};
  var expandedJob = Rx<Job?>(null);
  var expandedJobs = <Job, bool>{}.obs;

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
        tags: ["UI Design", "Interaction Design", "Figma", "React"],
        hourlyRateMin: "15",
        hourlyRateMax: "25",
        jobType: "Intermediate",
        estimatedTime: "1 to 3 months",
        hoursPerWeek: "Less than 30",
        isFixedPrice: true,
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
        hourlyRateMin: "10",
        hourlyRateMax: "15",
        jobType: "Intermediate",
        estimatedTime: "1 to 2 months",
        hoursPerWeek: "Less than 20",
        isFixedPrice: false,
      ),
    ];
    // Initialize expandedJobs map
    for (var job in jobs) {
      expandedJobs[job] = false;
    }
  }

  void toggleFavorite(Job job) {
    if (favoriteJobs.contains(job)) {
      favoriteJobs.remove(job);
      update();
    } else {
      favoriteJobs.add(job);
    }
    update();
  }

  // void removeFeedback(Job job) {
  //   selectedReasons.remove(job);
  //   if (expandedJob.value == job) {
  //     expandedJob.value = null;
  //   }
  // }

  void removeFeedback(Job job) {
    selectedReasons.remove(job);
  //  expandedJob.value = null;
    expandedJobs[job] = false;
  }

  void selectReasons(Job job, String reason) {
    selectedReasons[job] = reason;
    //expandedJob.value = job;
    //expandedJob.value = null;
    expandedJobs[job] = false;
    update();
  }

  void toggleExpand(Job job) {
    // print("expanded job ==> ${expandedJob.value},  job ==> ${job}");
    // expandedJob.value = expandedJob.value == job ? null : job;
    expandedJobs[job] = !(expandedJobs[job] ?? false);
    update();
  }

  // void toggleExpand(Job job) {
  //   print("expanded job ==> ${expandedJob.value},  job ==> ${job}");
  //   if (expandedJob.value == job) {
  //     expandedJob.value = null; // Collapse
  //   } else {
  //     expandedJob.value = job; // Expand
  //   }
  // }

  // void selectReason(String reason) {
  //   selectedReason.value = reason;
  //   Get.back();
  // }

  bool isReasonSelected(Job job) {
    return selectedReasons.containsKey(job);
  }
}