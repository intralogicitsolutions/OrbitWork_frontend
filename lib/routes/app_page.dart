import 'package:get/get.dart';
import 'package:orbitwork/routes/app_routes.dart';
import 'package:orbitwork/views/add_billing_method_page.dart';
import 'package:orbitwork/views/billing_and_payments.dart';
import 'package:orbitwork/views/chat_page.dart';
import 'package:orbitwork/views/contact_info_page.dart';
import 'package:orbitwork/views/createProfile/get_started.dart';
import 'package:orbitwork/views/createProfile/profile_setup.dart';
import 'package:orbitwork/views/help_and_support.dart';
import 'package:orbitwork/views/job_details_page.dart';
import 'package:orbitwork/views/jobs_page.dart';
import 'package:orbitwork/views/login.dart';
import 'package:orbitwork/views/membership_and_connects.dart';
import 'package:orbitwork/views/my_home_page.dart';
import 'package:orbitwork/views/my_stats_page.dart';
import 'package:orbitwork/views/onboarding.dart';
import 'package:orbitwork/views/password_security_page.dart';
import 'package:orbitwork/views/privacy_preferences_page.dart';
import 'package:orbitwork/views/profile_setting_page.dart';
import 'package:orbitwork/views/reports_page.dart';
import 'package:orbitwork/views/settings_page.dart';
import 'package:orbitwork/views/signup.dart';
import 'package:orbitwork/views/submit_proposal_page.dart';
import 'package:orbitwork/views/tax_forms_page.dart';
import 'package:orbitwork/widgets/profile_setup_container.dart';

import '../views/createProfile/freelancing_setup.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.login, page: () => LoginPage()),
    GetPage(name: AppRoutes.signup, page: () => SignUpPage()),
    GetPage(name: AppRoutes.onboarding, page: () => OnboardingPage()),
    GetPage(name: AppRoutes.homeScreen, page: () => MyHomePage()),
    GetPage(name: AppRoutes.jobs, page: () => JobsPage()),
    GetPage(name: AppRoutes.reports, page: () => ReportsPage()),
    GetPage(name: AppRoutes.setting, page: () => SettingPage()),
    GetPage(name: AppRoutes.helpAndSupport, page: () => HelpAndSupportPage()),
    GetPage(name: AppRoutes.jobDetails, page: () => JobDetailsView(job: Get.arguments,)),
    GetPage(name: AppRoutes.submitProposal, page: () => SubmitProposalPage()),
    GetPage(name: AppRoutes.submitProposal, page: () => SubmitProposalPage()),
    GetPage(name: AppRoutes.myStats, page: () => MyStatePage()),
    GetPage(name: AppRoutes.chat, page: () => ChatPage(name: Get.arguments,)),
    GetPage(name: AppRoutes.billingAndPayments, page: () => BillingAndPayments()),
    GetPage(name: AppRoutes.addBillingMethod, page: () => AddBillingMethod()),
    GetPage(name: AppRoutes.membershipAndConnects, page: () => MembershipAndConnects()),
    GetPage(name: AppRoutes.contactInfo, page: () => ContactInfoPage()),
    GetPage(name: AppRoutes.taxForm, page: () => TaxFormsPage()),
    GetPage(name: AppRoutes.profileSetting, page: () => ProfileSetting()),
    GetPage(name: AppRoutes.passwordAndSecurity, page: () => PasswordAndSecurity()),
    GetPage(name: AppRoutes.privacyPreferences, page: () => PrivacyPreferences()),
    /// Create User Profile ///
    GetPage(name: AppRoutes.getStarted, page: () => GetStarted(),),
    GetPage(name: AppRoutes.profileSetupContainer, page: () => ProfileSetupContainer(),),
    // GetPage(name: AppRoutes.profileSetup, page: () => ProfileSetup(),),
    // GetPage(name: AppRoutes.freelancingSetup, page: () => ProfileSetupView(),),
  ];
}