// import 'package:get/get.dart';
// import '../models/profile_metrics_model.dart';
//
// class ProfileMetricsController extends GetxController {
//   final RxList<ProfileMetricsModel> metricsData = <ProfileMetricsModel>[].obs;
//  // var metricsData = <ProfileMetricsModel>[].obs;
//   final RxInt currentTabIndex = 0.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchMetricsData();
//   }
//
//   void fetchMetricsData() {
//     metricsData.value = [
//       ProfileMetricsModel(views: 2, date: 'Jan 21', isAvailableBadgeOn: false),
//       ProfileMetricsModel(views: 1, date: 'Jan 23', isAvailableBadgeOn: false),
//       ProfileMetricsModel(views: 0, date: 'Jan 25', isAvailableBadgeOn: false),
//       ProfileMetricsModel(views: 0, date: 'Jan 27', isAvailableBadgeOn: false),
//     ];
//   }
//
//   void changeTab(int index) {
//     currentTabIndex.value = index;
//   }
// }



import 'package:get/get.dart';
import '../models/profile_metrics_model.dart';

class ProfileMetricsController extends GetxController {
  RxList<ProfileMetricsModel> metricsData = <ProfileMetricsModel>[].obs;
  RxInt totalViews = 0.obs;
  final RxInt currentTabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMetricsData();
  }

  void fetchMetricsData() {
    final data = [
      ProfileMetricsModel(views: 2, date: 'Jan 21', isAvailableBadgeOn: false),
      ProfileMetricsModel(views: 1, date: 'Jan 23', isAvailableBadgeOn: false),
      ProfileMetricsModel(views: 1, date: 'Jan 25', isAvailableBadgeOn: false),
      ProfileMetricsModel(views: 3, date: 'Jan 27', isAvailableBadgeOn: false),
    ];

    metricsData.value = data;
    totalViews.value = data.fold(0, (sum, item) => sum + item.views);
  }

  void changeTab(int index) {
    currentTabIndex.value = index;
  }
}

