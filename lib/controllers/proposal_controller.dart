import 'package:get/get.dart';

import '../models/chip_data.dart';
import '../models/proposal_model.dart';


class ProposalController extends GetxController {
  var proposals = <Proposal>[].obs;
  var activeProposals = <Proposal>[].obs;
  var archivedProposals = <Proposal>[].obs;
  var referralProposals = <Proposal>[].obs;
  var selectedTab = 'Active'.obs;
  var selectedChip = ''.obs;
  var selectedStatus = 'Submitted'.obs;

  // Counters for Active tab
  var offersCount = 0.obs;
  var invitesCount = 0.obs;
  var discussingCount = 0.obs;
  var submittedCount = 29.obs;

  // Counters for Referrals tab
  var jobsReferredCount = 0.obs;
  var freelancersReferredCount = 0.obs;

  // Counters for Archived tab
  var archivedProposalsCount = 15.obs;
  var archivedInvitesCount = 3.obs;

  @override
  void onInit() {
    super.onInit();
    loadActiveProposals();
    loadArchiveProposals();
  }

  void loadActiveProposals() {
    activeProposals.value = [
      Proposal(
        title: 'Full-Stack Developer Needed (MEAN/MERN Stack)',
        status: 'Active',
        date: DateTime(2025, 1, 20),
        viewedByClient: true,
        profileType: 'General Profile',
      ),
      Proposal(
        title: 'Vendor Module',
        status: 'Active',
        date: DateTime(2025, 1, 10),
        viewedByClient: false,
        profileType: 'General Profile',
      ),
      Proposal(
        title: 'Gig Posting Application Development',
        status: 'Active',
        date: DateTime(2025, 1, 9),
        viewedByClient: false,
        profileType: 'General Profile',
      ),
      Proposal(
        title: 'Nodejs API Integration',
        status: 'Active',
        date: DateTime(2024, 12, 26),
        viewedByClient: false,
        profileType: 'General Profile',
      ),
    ];
  }

  void loadArchiveProposals(){
    archivedProposals.value = [
      Proposal(
        title: 'NextJs: Chakra UI to Tailwind CSS',
        status: 'Active',
        date: DateTime(2025, 1, 28),
        isJobClosed: true,
        profileType: 'General Profile',
      ),
      Proposal(
        title: 'React Developer',
        status: 'Active',
        date: DateTime(2025, 1, 20),
        isJobClosed: true,
        profileType: 'General Profile',
      ),
      Proposal(
        title: 'Urgent required Vue.js front-end developer for long term',
        status: 'Active',
        date: DateTime(2025, 1, 1),
        isJobClosed: true,
        profileType: 'General Profile',
      ),
      Proposal(
        title: 'Mobile App Designer for Dream Journal',
        status: 'Active',
        date: DateTime(2024, 12, 31),
        isJobClosed: true,
        profileType: 'General Profile',
      ),
    ];
  }

  void changeTab(String tab) {
    selectedTab.value = tab;
  }

  List<Proposal> getCurrentProposals() {
    switch (selectedTab.value) {
      case 'Active':
        return activeProposals;
      case 'Archived':
        return archivedProposals;
      case 'Referrals':
        return referralProposals;
      default:
        return activeProposals;
    }
  }

  List<ChipData> getChipsForCurrentTab() {
    switch (selectedTab.value) {
      case 'Active':
        return [
          ChipData('Offers', offersCount.value),
          ChipData('Invites', invitesCount.value),
          ChipData('Discussing', discussingCount.value),
          ChipData('Submitted', submittedCount.value),
        ];
      case 'Referrals':
        return [
          ChipData('Jobs referred to you', jobsReferredCount.value),
          ChipData('Freelancers you referred', freelancersReferredCount.value),
        ];
      case 'Archived':
        return [
          ChipData('Proposals', archivedProposalsCount.value),
          ChipData('Invites', archivedInvitesCount.value),
        ];
      default:
        return [];
    }
  }

  void selectChip(String chipLabel) {
    selectedChip.value = chipLabel;
  }

}