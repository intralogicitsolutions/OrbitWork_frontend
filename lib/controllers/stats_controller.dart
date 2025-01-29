import 'package:get/get.dart';
import '../models/stats_model.dart';

class StatsController extends GetxController {
  var selectedDuration = 'Last 7 days'.obs;

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
}
