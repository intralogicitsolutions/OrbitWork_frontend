import 'package:get/get.dart';
import 'package:orbitwork/routes/app_routes.dart';
import 'package:orbitwork/views/add_bank_account.dart';
import 'package:orbitwork/views/add_billing_method_page.dart';
import 'package:orbitwork/views/agency_profile.dart';
import 'package:orbitwork/views/billing_and_payments.dart';
import 'package:orbitwork/views/buy_connects.dart';
import 'package:orbitwork/views/chat_page.dart';
import 'package:orbitwork/views/close_account.dart';
import 'package:orbitwork/views/connects_history.dart';
import 'package:orbitwork/views/contact_info_page.dart';
import 'package:orbitwork/views/createProfile/add_education.dart';
import 'package:orbitwork/views/createProfile/add_experience.dart';
import 'package:orbitwork/views/createProfile/add_languages.dart';
import 'package:orbitwork/views/createProfile/add_profile_title.dart';
import 'package:orbitwork/views/createProfile/get_started.dart';
import 'package:orbitwork/views/createProfile/photo_and_location.dart';
import 'package:orbitwork/views/createProfile/preview_profile.dart';
import 'package:orbitwork/views/createProfile/profile_creation_page.dart';
import 'package:orbitwork/views/createProfile/profile_setup.dart';
import 'package:orbitwork/views/createProfile/select_category.dart';
import 'package:orbitwork/views/createProfile/set_user_rate.dart';
import 'package:orbitwork/views/createProfile/skill_section.dart';
import 'package:orbitwork/views/createProfile/specialized_profile_tab/specialized_profile_1.dart';
import 'package:orbitwork/views/createProfile/write_an_overview.dart';
import 'package:orbitwork/views/create_client_account.dart';
import 'package:orbitwork/views/direct_to_local_bank.dart';
import 'package:orbitwork/views/get_paid.dart';
import 'package:orbitwork/views/help_and_support.dart';
import 'package:orbitwork/views/job_details_page.dart';
import 'package:orbitwork/views/jobs_page.dart';
import 'package:orbitwork/views/login.dart';
import 'package:orbitwork/views/membership_and_connects.dart';
import 'package:orbitwork/views/membership_plans.dart';
import 'package:orbitwork/views/my_home_page.dart';
import 'package:orbitwork/views/my_stats_page.dart';
import 'package:orbitwork/views/my_teams_page.dart';
import 'package:orbitwork/views/notification_settings_page.dart';
import 'package:orbitwork/views/onboarding.dart';
import 'package:orbitwork/views/password_security_page.dart';
import 'package:orbitwork/views/privacy_preferences_page.dart';
import 'package:orbitwork/views/profile_page.dart';
import 'package:orbitwork/views/profile_setting_page.dart';
import 'package:orbitwork/views/reports_page.dart';
import 'package:orbitwork/views/settings_page.dart';
import 'package:orbitwork/views/signup.dart';
import 'package:orbitwork/views/createProfile/skill_section_page.dart';
import 'package:orbitwork/views/submit_proposal_page.dart';
import 'package:orbitwork/views/tax_forms_page.dart';
import 'package:orbitwork/views/transaction_history_tab.dart';
import 'package:orbitwork/views/workroom_timesheet.dart';
import 'package:orbitwork/widgets/create_profile_container.dart';
import 'package:orbitwork/widgets/profile_setup_container.dart';

import '../views/createProfile/freelancing_setup.dart';
import '../views/overview_tab.dart';
import '../widgets/specialized_profile_container.dart';

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
    GetPage(name: AppRoutes.profilePage, page: () => ProfilePage(),),
    GetPage(name: AppRoutes.connectsHistory, page: () => ConnectsHistory(),),
    GetPage(name: AppRoutes.myTeams, page: () => MyTeamsPage(),),
    GetPage(name: AppRoutes.getPaid, page: () => GetPaidPage(),),
    GetPage(name: AppRoutes.directToLocalBank, page: () => DirectToLocalBank(wireTransfer: Get.arguments,),),
    GetPage(name: AppRoutes.addBankAccount, page: () => AddBankAccount(),),
    GetPage(name: AppRoutes.closeAccount, page: () => CloseAccount(),),
    GetPage(name: AppRoutes.createClientAccount, page: () => CreateClientAccount()),
    GetPage(name: AppRoutes.agencyProfile, page: () => AgencyProfile()),
    GetPage(name: AppRoutes.notificationSettings, page: () => NotificationSettings(),),
    GetPage(name: AppRoutes.buyConnects, page: () => BuyConnects(),),
    GetPage(name: AppRoutes.transactionHistory, page: () => TransactionHistoryTab(showAppbar: Get.arguments,),),
    GetPage(name: AppRoutes.overView, page: () => OverviewTab(showAppbar: Get.arguments,),),
    GetPage(name: AppRoutes.membershipPlans, page: () => MembershipPlans(),),
    GetPage(name: AppRoutes.workroomTimesheet, page: () => WorkRoomTimeSheet(),),

    /// Create User Profile ///

    GetPage(name: AppRoutes.getStarted, page: () => GetStarted(),),
    GetPage(name: AppRoutes.profileSetupContainer, page: () => ProfileSetupContainer(),),
    GetPage(name: AppRoutes.profileCreation, page: () => ProfileCreationPage(),),
    GetPage(name: AppRoutes.selectCategory, page: () => SelectCategory(),),
    GetPage(name: AppRoutes.skillSection, page: () => SkillsSelectionScreen(),),
    GetPage(name: AppRoutes.profileSkill, page: () => ProfileSkillView(),),
    GetPage(name: AppRoutes.profileTitle, page: () => ProfileTitleView(),),
    GetPage(name: AppRoutes.addExperience, page: () => AddExperience(),),
    GetPage(name: AppRoutes.addEducation, page: () => AddEducation(),),
    GetPage(name: AppRoutes.addLanguages, page: () => AddLanguages(),),
    GetPage(name: AppRoutes.writeAnOverview, page: () => WriteAnOverview(),),
    GetPage(name: AppRoutes.setUserRate, page: () => SetUserRate(),),
    GetPage(name: AppRoutes.photoAndLocation, page: () => PhotoAndLocation(),),
    GetPage(name: AppRoutes.previewProfile, page: () => PreviewProfile(),),
    GetPage(name: AppRoutes.specializedProfile, page: () => SpecializedProfileContainer(),),

    GetPage(name: AppRoutes.createProfileContainer, page: () => CreateProfileContainer(),)
  ];
}