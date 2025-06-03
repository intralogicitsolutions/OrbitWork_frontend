import 'package:get/get.dart';

import '../client_profile_model/freelancer_model.dart';

class FreelancerController extends GetxController {
  RxList<Freelancer> freelancers = <Freelancer>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFreelancers();
  }

  void fetchFreelancers() {
    freelancers.value = [
      Freelancer(
        name: "Minhaz U.",
        title: "Graphic Designer | Banner Ads & UI/UX Design",
        country: "Bangladesh",
        rate: 15,
        earnings: 100000,
        jobSuccess: 95,
        isAvailable: true,
        profileImage: "https://example.com/minhaz.jpg", // Replace with real URL
        skills: ["Brand Identity & Guidelines", "Advertising Design"],
        isBoosted: true,
        agencyName: "Creative Wisdom",
        agencyEarnings: 60000,
      ),
      Freelancer(
        name: "Rahul B.",
        title: "Top 1 percent Google ads, Fb Ads, Paid Ads, PPC",
        country: "India",
        rate: 15,
        earnings: 900000,
        jobSuccess: 95,
        isAvailable: true,
        profileImage: "https://example.com/rahul.jpg", // Replace with real URL
        skills: [],
        isBoosted: false,
        agencyName: "",
        agencyEarnings: 0,
      ),
    ];
  }
}
