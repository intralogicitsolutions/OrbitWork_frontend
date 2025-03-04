import 'package:get/get.dart';
import '../models/stats_model.dart';

class StatsController extends GetxController {
  var selectedDuration = 'Last 7 days'.obs;


  var completionPercentage = 70.0.obs;
  var isEmploymentHistoryCompleted = false.obs;
  var showCompletedItems = false.obs;

  final stats = Rx<StatsModel>(
    StatsModel(
      earnings: 0.0,
      jobSuccessScore: 80,
      profileViews: 3,
      lastUpdated: 'Jan 28',
      proposalsSent: 0,
      proposalsViewed: 1,
      interviews: 0,
      hires: 0,
      clientRelationshipScore: 67,
      connectsLeft: 120,
      isTopRated: true,
    ),
  );

  @override
  void onInit() {
    super.onInit();
    fetchStats();
  }

  void fetchStats() {
    stats.value = StatsModel(
      earnings: 1234.56,
      jobSuccessScore: 70,
      profileViews: 3,
      lastUpdated: 'Jan 28',
      proposalsSent: 0,
      proposalsViewed: 1,
      interviews: 0,
      hires: 0,
      clientRelationshipScore: 67,
      connectsLeft: 120,
      isTopRated: true,
    );
  }

  void changeTimeRange(String value) {
    selectedDuration.value = value;
  }

  void updateEmploymentHistory(bool completed) {
    isEmploymentHistoryCompleted.value = completed;
    updateCompletionPercentage();
  }

  void updateCompletionPercentage() {
    // Logic to calculate completion percentage based on different fields
    // For this example, we'll just update it to 90% when employment history is completed
    if (isEmploymentHistoryCompleted.value) {
      completionPercentage.value = 90.0;
    }
  }
}
