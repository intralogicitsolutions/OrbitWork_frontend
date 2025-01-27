import 'package:get/get.dart';

class ClientsHistoryController extends GetxController{

  var isExpanded = false.obs;
  var showFullList = false.obs;
  var isJobsExpanded = false.obs; // For Jobs in Progress
  var displayLimit = 5.obs;

  var recentHistory = [
    {
      'title': 'Operations Support Role',
      'rating': 4.0,
      'freelancer': 'Jessica R.',
      'hours': 6,
      'rate': 9,
      'billed': 61.23,
    },
    {
      'title': 'Jira Admin /Certified Atlassian Shop',
      'rating': 4.8,
      'freelancer': 'Esteban H.',
      'hours': 0,
      'rate': 40,
      'billed': 4653.25,
    },
    {
      'title': 'Logo ReDesign',
      'rating': 5.0,
      'freelancer': 'Marharyta P.',
      'billed': 100,
    },
    {
      'title': 'Flutter Application',
      'rating': 4.8,
      'freelancer': 'Jessica R.',
      'hours': 8,
      'rate': 90,
      'billed': 91.23,
    },
    {
      'title': 'Operations Support Role',
      'rating': 4.0,
      'freelancer': 'Jessica R.',
      'hours': 6,
      'rate': 9,
      'billed': 61.23,
    },
    {
      'title': 'Jira Admin /Certified Atlassian Shop',
      'rating': 4.8,
      'freelancer': 'Esteban H.',
      'hours': 0,
      'rate': 40,
      'billed': 4653.25,
    },
    {
      'title': 'Logo ReDesign',
      'rating': 5.0,
      'freelancer': 'Marharyta P.',
      'billed': 100,
    },
    {
      'title': 'Flutter Application',
      'rating': 4.8,
      'freelancer': 'Jessica R.',
      'hours': 8,
      'rate': 90,
      'billed': 91.23,
    }
  ].obs;


  var jobsInProgress = [
    {'title': 'App Development', 'freelancer': 'John Doe'},
    {'title': 'UI Design', 'freelancer': 'Jane Smith'},
    {'title': 'API Integration', 'freelancer': 'Mike Ross'},
    {'title': 'Bug Fixing', 'freelancer': 'Sara Johnson'},
    {'title': 'Database Optimization', 'freelancer': 'Emma Watson'},
    {'title': 'Server Configuration', 'freelancer': 'Chris Brown'},
    {'title': 'Project Testing', 'freelancer': 'Robert Green'},
    {'title': 'App Development', 'freelancer': 'John Doe'},
    {'title': 'UI Design', 'freelancer': 'Jane Smith'},
    {'title': 'API Integration', 'freelancer': 'Mike Ross'},
    {'title': 'Bug Fixing', 'freelancer': 'Sara Johnson'},
    {'title': 'Database Optimization', 'freelancer': 'Emma Watson'},
    {'title': 'Server Configuration', 'freelancer': 'Chris Brown'},
    {'title': 'Project Testing', 'freelancer': 'Robert Green'},
  ].obs;

  // void toggleExpanded(){
  //   isExpanded.value = !isExpanded.value;
  // }

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }

  void toggleJobsExpanded() {
    isJobsExpanded.value = !isJobsExpanded.value;
    print('is job expanded ==> ${isJobsExpanded}');
    // if (!isJobsExpanded.value) {
    //   displayLimit.value = 5;
    // }
  }

  void toggleShowFullList() {
    showFullList.value = !showFullList.value;
  }

  void increaseDisplayLimit() {
    if (displayLimit.value < jobsInProgress.length) {
      displayLimit.value += 5;
    }
  }

  void resetDisplayLimit() {
    displayLimit.value = 5;
  }
}
