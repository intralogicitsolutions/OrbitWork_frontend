import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../client_profile_model/feedback_item_model.dart';
import '../component/client_profile/select_like_bottomsheet.dart';

class ClientProfileController extends GetxController{
  var isOnline = true.obs;
  var isFavorite = false.obs;
  var selectedTab = 0.obs;

  VideoPlayerController? videoPlayerController;
  var isVideoInitialized = false.obs;
  var isPlaying = false.obs;

  RxString selectedOption = 'Newest first'.obs;

  List<GlobalKey> sectionKeys = List.generate(8, (_) => GlobalKey());

  final ScrollController scrollController = ScrollController();


  // Keys for each section
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey clientFeedbackKey = GlobalKey();
  final GlobalKey workHistoryKey = GlobalKey();
  final GlobalKey portfolioKey = GlobalKey();
  final GlobalKey employmentHistoryKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey certificationKey = GlobalKey();
  final GlobalKey educationKey = GlobalKey();

  List<String> tabTitles = [
    'About',
    'Client feedback',
    'Work history',
    'Portfolio',
    'Employment history',
    'Skills',
    'Certification',
    'Education',
  ];

  var feedbackList = <FeedbackItem>[
    FeedbackItem(
      title: "Local SEO citations consultant",
      date: "March 18, 2025",
      rating: 5.0,
      comment: "It was a good experience overall...",
      clientName: "Remote Roofing A.",
    ),
    FeedbackItem(
      title: "Google Ads optimization",
      date: "March 2, 2025",
      rating: 4.0,
      comment: "Quick delivery and insightful changes.",
      clientName: "Alpha Designs",
    ),
    // Add more items as needed
  ].obs;

  RxList<String> allSkills = <String>[
    "Figma", "Web Design", "User Experience Design", "Mockup", "Responsive Design",
    "Mobile App Design", "UX & UI", "UI/Ux Prototyping", "Webflow", "Sketch",
    "Adobe XD", "Interaction Design", "Wireframe", "Design System"
  ].obs;

  RxBool expanded = false.obs;


  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
    // initializeVideoPlayer();
  }


  void _onScroll() {
    List<GlobalKey> keys = [
      aboutKey,
      clientFeedbackKey,
      workHistoryKey,
      portfolioKey,
      employmentHistoryKey,
      skillsKey,
      certificationKey,
      educationKey,
    ];

    double scrollPosition = scrollController.position.pixels;

    for (int i = keys.length - 1; i >= 0; i--) {
      final RenderBox? renderBox = keys[i].currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final position = renderBox.localToGlobal(Offset.zero);
        // Adjust for app bar height and tab bar height
        if (position.dy <= 200) { // 200 is approximate height of fixed content
          selectedTab.value = i;
          break;
        }
      }
    }
  }

  void scrollToSection(int index) {
    List<GlobalKey> keys = [
      aboutKey,
      clientFeedbackKey,
      workHistoryKey,
      portfolioKey,
      employmentHistoryKey,
      skillsKey,
      certificationKey,
      educationKey,
    ];

    if (index < keys.length) {
      final RenderBox? renderBox = keys[index].currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final position = renderBox.localToGlobal(Offset.zero);
        final offset = scrollController.offset + position.dy - 200; // Adjust for fixed header

        scrollController.animateTo(
          offset,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void toggleOnlineStatus() {
    isOnline.value = !isOnline.value;
  }

  void toggleFavorite() {
   isFavorite.value = !isFavorite.value;
    Get.bottomSheet(SelectLikeBottomsheet());
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }

  // void initializeVideoPlayer() {
  //   videoPlayerController = VideoPlayerController.network(
  //     'https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_1mb.mp4',
  //   );
  //
  //   videoPlayerController!.initialize().then((_) {
  //     isVideoInitialized.value = true;
  //     update();
  //   });
  //
  //   videoPlayerController!.addListener(() {
  //     isPlaying.value = videoPlayerController!.value.isPlaying;
  //   });
  // }

  void toggleVideoPlayback() {
    if (videoPlayerController!.value.isPlaying) {
      videoPlayerController!.pause();
    } else {
      videoPlayerController!.play();
    }
  }


  @override
  void onClose() {
    videoPlayerController?.dispose();
    super.onClose();
  }
}