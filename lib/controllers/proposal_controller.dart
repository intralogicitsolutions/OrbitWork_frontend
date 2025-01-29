import 'package:get/get.dart';
import '../models/attachment_model.dart';
import '../models/proposal_models.dart';
import 'package:file_picker/file_picker.dart';

class ProposalController extends GetxController {
  final isDescriptionExpanded = false.obs;
  final proposal = Rx<ProposalModel?>(null);
  RxBool isLoading = true.obs;
  var selectedDuration = 'Select a duration'.obs;


  final bidAmount = 0.0.obs;
  final serviceFeePercentage = 0.10;
  final coverLetter = ''.obs;
  final attachments = <AttachmentModel>[].obs;
  final profileHighlights = <ProfileHighlightModel>[].obs;
  final maxAttachments = 5;
  final maxFileSize = 25 * 1024 * 1024;
  final showInfoCard = true.obs;
  final highlightItems = <HighlightItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with default items
    loadProposalData();
    highlightItems.addAll([
      HighlightItemModel(
        id: '1',
        title: 'Add an Orbitwork job',
        icon: '💼',
      ),
      HighlightItemModel(
        id: '2',
        title: 'Add a portfolio project',
        icon: '🎨',
      ),
      HighlightItemModel(
        id: '3',
        title: 'You don\'t have any certificates.',
        icon: '🏅',
        isEnabled: false,
      ),
    ]);
  }


  void dismissInfoCard() {
    showInfoCard.value = false;
  }

  void loadProposalData() async {
    await Future.delayed(Duration(seconds: 2));
    proposal.value = ProposalModel(
      requiredConnects: 14,
      remainingConnects: 112,
      jobTitle: '[${250}] Attachments: PDF preview loads with delay, the grey line shown first #55671 - Expensify',
      category: 'Mobile App Development',
      postedDate: 'Jan 27, 2025',
      description: 'Expensify is a team of generalists developing today\'s leading expense management tool. Maintaining our reputation as an innovative leader in the world of finance requires an incredibly reliable and secure system for processing financial transactions. Accordingly, we primarily leverage time-tested...',
      budget: 250.0,
      bid: 250.0,
      serviceFee: 250.0 * 0.10,
      finalAmount: 250.0 - (250.0 * 0.10),
      duration: '',
      coverLetter: '',
    );
    isLoading.value = false; // Loading complete
  }

  void seeWhatsNew() {
    Get.snackbar(
      'New Features',
      'Checking new portfolio features...',
      snackPosition: SnackPosition.BOTTOM,
    );
  }



  void updateBidAmount(double amount) {
    bidAmount.value = amount;
  }

  void updateBid(String value) {
    double bidAmount = double.tryParse(value) ?? 0.0;
    print('bidAmount ==> ${bidAmount}');
    proposal.update((val) {
      val?.bid = bidAmount;
      val?.serviceFee = bidAmount * serviceFeePercentage;
      val?.finalAmount = bidAmount - (bidAmount * serviceFeePercentage);
    });
  }

  void updateDuration(String value) {
    proposal.update((val) {
      val?.duration = value;
    });
  }

  void updateCoverLetter(String value) {
    proposal.update((val) {
      val?.coverLetter = value;
    });
  }

  void toggleDescriptionExpansion() {
    isDescriptionExpanded.value = !isDescriptionExpanded.value;
  }

  Future<void> pickFile() async {
    if (attachments.length >= maxAttachments) {
      Get.snackbar(
        'Error',
        'Maximum 5 files allowed',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final remainingSlots = maxAttachments - attachments.length;

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withData: true,
    );

    if (result != null) {
      // PlatformFile file = result.files.first;
      final filesToAdd = result.files.take(remainingSlots);

      for (PlatformFile file in filesToAdd) {
        if (file.size > maxFileSize) {
          Get.snackbar(
            'Error',
            'File size must be under 25MB',
            snackPosition: SnackPosition.BOTTOM,
          );
          //return;
          continue;
        }

        attachments.add(AttachmentModel(
          fileName: file.name,
          filePath: file.path ?? '',
          fileSize: file.size / (1024 * 1024), // Convert to MB
        ));
      }
      if (attachments.length >= maxAttachments) {
        Get.snackbar(
          'Info',
          'Maximum file limit (5) reached',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  void removeAttachment(int index) {
    attachments.removeAt(index);
  }

  // void updateCoverLetter(String value) {
  //   coverLetter.value = value;
  // }

  void addProfileHighlight(ProfileHighlightModel highlight) {
    if (profileHighlights.length < 4) {
      profileHighlights.add(highlight);
    }
  }

  void removeProfileHighlight(String id) {
    profileHighlights.removeWhere((element) => element.id == id);
  }


  void submitProposal() {
    // Implement your submission logic here
    print('Submitting proposal: ${proposal.value}');
    Get.snackbar(
      'Success',
      'Proposal submitted successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void updateDurations(String value) {
    selectedDuration.value = value;
    Get.back(); // Close BottomSheet after selection
  }
}
