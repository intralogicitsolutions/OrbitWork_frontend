import 'package:get/get.dart';
import 'package:orbitwork/routes/app_routes.dart';
import 'package:orbitwork/views/chat_page.dart';
import 'package:orbitwork/views/help_and_support.dart';
import 'package:orbitwork/views/job_details_page.dart';
import 'package:orbitwork/views/jobs_page.dart';
import 'package:orbitwork/views/login.dart';
import 'package:orbitwork/views/my_home_page.dart';
import 'package:orbitwork/views/my_stats_page.dart';
import 'package:orbitwork/views/onboarding.dart';
import 'package:orbitwork/views/reports_page.dart';
import 'package:orbitwork/views/settings_page.dart';
import 'package:orbitwork/views/signup.dart';
import 'package:orbitwork/views/submit_proposal_page.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.login, page: () => LoginPage()),
    GetPage(name: AppRoutes.signup, page: () => SignUpPage()),
    GetPage(name: AppRoutes.onboarding, page: () => OnboardingPage()),
    GetPage(name: AppRoutes.homeScreen, page: () => MyHomePage()),
    GetPage(name: AppRoutes.jobs, page: () => JobsPage()),
    GetPage(name: AppRoutes.reports, page: () => ReportsPage()),
    GetPage(name: AppRoutes.setting, page: () => SettingPage()),
    GetPage(name: AppRoutes.heplandsupport, page: () => HelpAndSupportPage()),
    GetPage(name: AppRoutes.jobdetails, page: () => JobDetailsView(job: Get.arguments,)),
    GetPage(name: AppRoutes.submitproposal, page: () => SubmitProposalPage()),
    GetPage(name: AppRoutes.submitproposal, page: () => SubmitProposalPage()),
    GetPage(name: AppRoutes.mystats, page: () => MyStatePage()),
    GetPage(name: AppRoutes.chat, page: () => ChatPage(name: Get.arguments,)),
  ];
}