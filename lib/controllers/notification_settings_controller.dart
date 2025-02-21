import 'package:get/get.dart';

class NotificationSettingsController extends GetxController {
  final RxBool playSound = false.obs;
  final RxString desktopNotificationLevel = 'All activity'.obs;
  final RxString desktopMessageCounter = 'All activity'.obs;
  final RxString mobileNotificationLevel = 'All activity'.obs;
  final RxString mobileMessageCounter = 'All activity'.obs;
  final RxString emailActivityLevel = 'All activity'.obs;
  final RxString emailFrequency = 'Every 15 minutes'.obs;
  final RxBool onlyWhenOffline = false.obs;
  final String userEmail = 'i******23@gmail.com';

  final RxBool receiveTax = false.obs;

  var selectedJobOption = 'Only jobs I post'.obs;
  var selectedFreelancerOption = 'Only freelancers I hire'.obs;

  var jobPostingSettings = <Map<String, bool>>[
    {'A job is posted or modified': true},
    {'A proposal is received': true},
    {'An interview is accepted or offer terms are modified': true},
    {'An interview or offer is declined or withdrawn': true},
    {'An offer is accepted': true},
    {'A job posting will expire soon': true},
    {'A job posting expired': true},
    {'No interviews have been initiated': true},
  ].obs;

  var proposalSettings = <Map<String, bool>>[
    {'An interview is initiated': true},
    {'An offer or interview invitation is received': true},
    {'An offer or interview invitation is withdrawn': true},
    {'A proposal is rejected': true},
    {'A job I applied to has been cancelled or closed': true},
    {'A proposal is withdrawn': true},
  ].obs;

  var contractSettings = <Map<String, bool>>[
    {'A hire is made or a contract begins': true},
    {'Time logging begins': true},
    {'Contract terms are modified': true},
    {'A contract ends': true},
    {'A timelog is ready for review': true},
    {'Feedback changes are made': true},
    {'Daily snapshot of time recorded by your freelancers': true},
    {'Weekly billing digest': true},
    {'Other contract related messages': true},
    {'Payment receipts and other financial related emails': false},
  ].obs;

  var groupSettings = <Map<String, bool>>[
    {'Group membership events occur': true},
    {'Someone forwards me a freelancer\'s profile': true},
    {'Someone sends me an invitation': true},
    {'Team access is revoked': true},
  ].obs;

  var membershipSettings = <Map<String, bool>>[
    {'Subscription related event occur': true},
  ].obs;

  var miscellaneousSetting = <Map<String, bool>>[
    {'Orbitwork has a tip to help me start': true},
    {'Notify me of Orbitwork events happening in my local area': true},
    {'Notify me of who viewed my job post': true},
    {'I have connects expiring soon': true},
    {'I have purchased or received connects': true}
  ].obs;

  var projectSetting = <Map<String, bool>>[
    {'Send recommendations if I qualify as top Orbitwork talent': true}
  ].obs;

  var communicationSetting = <Map<String, bool>>[
    {'Send me genuinely useful emails every now and then to help me get the most out of Orbitwork': true}
  ].obs;


  final RxList<String> selectedReasons = <String>[].obs;

  final RxInt selectedTabIndex = 0.obs;

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  void togglePlaySound(bool value) {
    playSound.value = value;
  }

  void updateDesktopNotificationLevel(String value) {
    desktopNotificationLevel.value = value;
  }

  void updateDesktopMessageCounter(String value) {
    desktopMessageCounter.value = value;
  }

  void updateMobileNotificationLevel(String value) {
    mobileNotificationLevel.value = value;
  }

  void updateMobileMessageCounter(String value) {
    mobileMessageCounter.value = value;
  }

  void updateEmailActivityLevel(String value) {
    emailActivityLevel.value = value;
  }

  void updateEmailFrequency(String value) {
    emailFrequency.value = value;
  }

  void toggleOfflineOnly(bool value) {
    onlyWhenOffline.value = value;
  }

  void toggleReason(String reason) {
    if (selectedReasons.contains(reason)) {
      selectedReasons.remove(reason);
    } else {
      selectedReasons.add(reason);
    }
  }


  void toggleJobPostingSetting(int index) {
    var setting = jobPostingSettings[index];
    var key = setting.keys.first;
    jobPostingSettings[index] = {key: !setting.values.first};
    update();
  }

  void toggleProposalSetting(int index) {
    var setting = proposalSettings[index];
    var key = setting.keys.first;
    proposalSettings[index] = {key: !setting.values.first};
    update();
  }

  void toggleContractSetting(int index) {
    var setting = contractSettings[index];
    var key = setting.keys.first;
    contractSettings[index] = {key: !setting.values.first};
    update();
  }

  void toggleGroupSetting(int index) {
    var setting = groupSettings[index];
    var key = setting.keys.first;
    groupSettings[index] = {key: !setting.values.first};
    update();
  }

  void toggleMembershipSetting(int index) {
    var setting = membershipSettings[index];
    var key = setting.keys.first;
    membershipSettings[index] = {key: !setting.values.first};
    update();
  }

  void toggleMiscellaneousSetting(int index) {
    var setting = miscellaneousSetting[index];
    var key = setting.keys.first;
    miscellaneousSetting[index] = {key: !setting.values.first};
    update();
  }

  void toggleProjectSetting(int index) {
    var setting = projectSetting[index];
    var key = setting.keys.first;
    projectSetting[index] = {key: !setting.values.first};
    update();
  }

  void toggleCommunicationSetting(int index) {
    var setting = communicationSetting[index];
    var key = setting.keys.first;
    communicationSetting[index] = {key: !setting.values.first};
    update();
  }


  void updateJobOption(String value) {
    selectedJobOption.value = value;
  }

  void updateFreelancerOption(String value) {
    selectedFreelancerOption.value = value;
  }

  void toggleReceiveTax(bool value) {
    receiveTax.value = value;
  }
}