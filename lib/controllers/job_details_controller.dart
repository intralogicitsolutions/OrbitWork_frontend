import 'package:get/get.dart';
import '../models/job_detail_model.dart';

class JobDetailsController extends GetxController {
  final jobs = <Map<String, String>>[].obs;

  var showAllJobs = false.obs;

  List<Map<String, String>> get initialJobs => jobs.take(5).toList();

  List<Map<String, String>> get remainingJobs => jobs.skip(5).toList();

  // void toggleShowAll() {
  //   showAllJobs.value = !showAllJobs.value;
  // }

  void toggleShowAll(bool showAll) {
    showAllJobs.value = showAll;
  }

  Future<void> fetchJobs() async {
    await Future.delayed(const Duration(seconds: 2));
    jobs.value = [
      {'title': 'Isolation of user access on Windows Server', 'type': 'Fixed-price'},
      {'title': 'C# scraper: migrate to Anglesharp', 'type': 'Fixed-price'},
      {'title': 'Add 5 fields extraction to existing parser', 'type': 'Fixed-price'},
      {'title': 'Build a .NET Console App to scrape listings', 'type': 'Fixed-price'},
      {'title': 'Refactor React component', 'type': 'Fixed-price'},
      {'title': 'Create a REST API for ecommerce', 'type': 'Fixed-price'},
      {'title': 'Update database schema and migrate data', 'type': 'Fixed-price'},
    ];
  }


  final JobDetailsModel jobDetails = JobDetailsModel(
    title: 'Fix clerk adding issue into a simple react app',
    description: 'I am adding clerk user management to react app (simple one, created with create-react-app). However getting issue.',
    expertise: 'Specialized profiles can help you better highlight your expertise when submitting proposals to jobs like these.',
    location: 'Worldwide',
    connects: 11,
    availableConnects: 26,
    price: 5.0,
    experienceLevel: 'Intermediate',
    projectType: 'One-time project',
    hirers: 96,
    activeHirers: 18,
    avgHourlyRate: 11.75,
    industry: 'Agriculture & Forestry',
    tokmakTime: '9:44 AM',
    hireRate: 28,
    openJobs: 8,
    jobsPosted: 340,
    totalSpent: 28000,
    hours: '8',
    sinceDate: 'Jul 12, 2017',
  );
}