import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:orbitwork/repository/api/api_constants.dart';
import '../global/tokenStorage.dart';
import '../models/job_model.dart';

class JobsController extends GetxController {
  var jobs = <Job>[].obs;
  var favoriteJobs = <Job>[].obs;
  var selectedReason = "".obs;
  var selectedReasons = <Job, String>{};
  var expandedJob = Rx<Job?>(null);
  var expandedJobs = <Job, bool>{}.obs;
  //RxBool isLoading = true.obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchJobs();
  }

  // void fetchJobs() async{
  //   await Future.delayed(Duration(seconds: 2));
  //   jobs.value = [
  //     Job(
  //       title: "Support on inside page User Interface Design",
  //       description: "Hi, we have one of our pages, which will function as an internal user ad.",
  //       postedTimeAgo: "1 hour",
  //       location: "India",
  //       budget: 300,
  //       paymentVerified: "Payment verified",
  //       rating: 5.0,
  //       tags: ["UI Design", "Interaction Design", "Figma", "React"],
  //       hourlyRateMin: "15",
  //       hourlyRateMax: "25",
  //       jobType: "Intermediate",
  //       estimatedTime: "1 to 3 months",
  //       hoursPerWeek: "Less than 30",
  //       isFixedPrice: true,
  //     ),
  //     Job(
  //       title: "Mobile App Development",
  //       description: "Looking for an expert in Flutter for a mobile app project.",
  //       postedTimeAgo: "2 hour",
  //       location: "USA",
  //       budget: 1000,
  //       paymentVerified: "Payment verified",
  //       rating: 4.8,
  //       tags: ["Flutter", "Dart", "Mobile Development"],
  //       hourlyRateMin: "10",
  //       hourlyRateMax: "15",
  //       jobType: "Intermediate",
  //       estimatedTime: "1 to 2 months",
  //       hoursPerWeek: "Less than 20",
  //       isFixedPrice: false,
  //     ),
  //   ];
  //   isLoading.value = false;
  //   for (var job in jobs) {
  //     expandedJobs[job] = false;
  //   }
  // }

  void toggleFavorite(Job job) {
    if (favoriteJobs.contains(job)) {
      favoriteJobs.remove(job);
      update();
    } else {
      favoriteJobs.add(job);
    }
    update();
  }

  void removeFeedback(Job job) {
    selectedReasons.remove(job);
    expandedJobs[job] = false;
  }

  void selectReasons(Job job, String reason) {
    selectedReasons[job] = reason;
    expandedJobs[job] = false;
    update();
  }

  void toggleExpand(Job job) {
    expandedJobs[job] = !(expandedJobs[job] ?? false);
    update();
  }

  bool isReasonSelected(Job job) {
    return selectedReasons.containsKey(job);
  }

  // Future<void> fetchJobs() async {
  //   isLoading.value = true;
  //   String? token = await TokenStorage.getToken();
  //   try {
  //     final response = await http.get(
  //       Uri.parse(ApiConstants.GET_JOB),
  //       headers: {
  //         'Authorization': '$token',
  //       },
  //     );
  //     isLoading.value = false;
  //     if (response.statusCode == 200) {
  //      // final Map<String, dynamic> data = json.decode(response.body);
  //       final List<dynamic> jsonData = json.decode(response.body);
  //       jobs.value = jsonData.map((job) => Job.fromJson(job)).toList();
  //       print("Api Response: $jsonData");
  //      // return data['data'] ?? [];
  //     } else {
  //       throw Exception("Failed to load jobs: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     isLoading.value = false;
  //     print("Error fetching jobs: $e");
  //     //return [];
  //   }
  // }

  Future<void> fetchJobs() async {
    isLoading.value = true;
    String? token = await TokenStorage.getToken();

    try {
      final response = await http.get(
        Uri.parse(ApiConstants.GET_JOB),
        headers: {
          'Authorization': '$token',
          'Content-Type': 'application/json',
        },
      );

      isLoading.value = false;

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey("body") && data["body"] is List) {
          final List<dynamic> jsonData = data["body"]; // Extracting 'body' list

          jobs.value = jsonData.map((job) => Job.fromJson(job)).toList();
          print("API Response: ${json.encode(jsonData)}");
        } else {
          throw Exception("Invalid API response structure: ${response.body}");
        }
      } else {
        throw Exception("Failed to load jobs: ${response.statusCode}");
      }
    } catch (e) {
      isLoading.value = false;
      print("Error fetching jobs: $e");
    }
  }
}