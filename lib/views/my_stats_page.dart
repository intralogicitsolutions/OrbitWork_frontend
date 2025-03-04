import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/views/tabs/impressions_tab.dart';
import 'package:orbitwork/views/tabs/invites_tab.dart';
import 'package:orbitwork/views/tabs/profile_view_tab.dart';
import 'package:path/path.dart';
import '../component/Explore_work_bottomsheet.dart';
import '../component/badges_bottomsheet.dart';
import '../component/complete_your_profile_bottomsheet.dart';
import '../component/job_success_score_bottomsheet.dart';
import '../component/score_range_bottomsheet.dart';
import '../controllers/profile_matrics_controller.dart';
import '../controllers/stats_controller.dart';
import '../routes/app_routes.dart';
import '../widgets/select_duration_bottomsheet.dart';

class MyStatePage extends StatelessWidget {
  //const MyStatePage({Key? key}) : super(key: key);

  final StatsController controller = Get.put(StatsController());
  final ProfileMetricsController profileMetricsController =
      Get.put(ProfileMetricsController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text('My stats'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My stats',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'View proposal history, earnings, profile analytics, and your Job Success Score.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Stats are not updated in real-time and may take up to 24 hours to reflect recent activity.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              _buildEarningsSection(),
              const Divider(height: 32),
              _buildJobSuccessScore(),
              const Divider(height: 32),
              _buildProfileMetrics(context),
              const Divider(height: 24),
              _buildProposals(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEarningsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '12-month earnings',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Obx(() => Text(
                '\$${controller.stats.value.earnings}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              )),
        ),
        // const SizedBox(height: 8),
        Center(
          child: TextButton(
            onPressed: () {
              Get.toNamed(AppRoutes.transactionHistory, arguments: true);
            },
            child: Text(
              'Transaction history',
              style: TextStyle(color: Get.theme.primaryColor, decoration: TextDecoration.underline,
              decorationColor: Get.theme.primaryColor
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildJobSuccessScore() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Job Success Score',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.help_outline),
              onPressed: () {
                Get.bottomSheet(
                  Container(
                      height: Get.height * 0.5,
                      child: JobSuccessScoreBottomsheet()),
                  isScrollControlled: true,
                  isDismissible: true
                );
              },
            ),
          ],
        ),
        // const SizedBox(height: 16),
        SizedBox(
          height: 100,
          width: 100,
          child: Stack(
            children: [
              Center(
                child: Container(
                  height: 70,
                  width: 70,
                  child: CircularProgressIndicator(
                    value: controller.stats.value.jobSuccessScore / 100,
                    strokeWidth: 8,
                    backgroundColor: Colors.blue.withOpacity(0.2),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
              ),
              Center(
                child: Obx(() => Text(
                      '${controller.stats.value.jobSuccessScore}%',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Excellent',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                Get.bottomSheet(
                    Container(
                        height: Get.height * 0.7,
                        child: ScoreRangeBottomsheet()),
                    isScrollControlled: true,
                    isDismissible: true
                );
              },
                child: Icon(Icons.help_outline)),
          ],
        ),
        const SizedBox(height: 8),
        Obx(() => Text(
              'As of ${controller.stats.value.lastUpdated}, updates daily',
              style: const TextStyle(color: Colors.grey),
            )),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: () {
            Get.toNamed(AppRoutes.jobSuccessInsights);
          },
          child: const Text(
            'View insights',
            style: TextStyle(color: Colors.green),
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.grey),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileMetrics(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Profile metrics',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Obx(() {
              return OutlinedButton(
                onPressed: () {
                  //showBottomSheet(context);
                  showDurationBottomSheet(context, (selectedValue) {
                    controller.selectedDuration.value = selectedValue;
                  });
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      controller.selectedDuration.value,
                      style: TextStyle(color: theme.secondaryHeaderColor),
                    ),
                    const SizedBox(width: 5), // Space between text and icon
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 20,
                      color: theme.secondaryHeaderColor,
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
        const SizedBox(height: 24),
        DefaultTabController(
          length: 3,
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TabBar(
                  isScrollable: true,
                  labelPadding: EdgeInsets.symmetric(horizontal: 16),
                  tabAlignment: TabAlignment.start,
                  onTap: profileMetricsController.changeTab,
                  labelColor: theme.primaryColor,
                  unselectedLabelColor: theme.unselectedWidgetColor,
                  indicatorColor: theme.primaryColor,
                  // isScrollable: true,
                  tabs: const [
                    Tab(text: 'Profile views'),
                    Tab(text: 'Invites'),
                    Tab(text: 'Impressions and clicks'),
                  ],
                ),
                Expanded(
                  child: Obx(() {
                    switch (profileMetricsController.currentTabIndex.value) {
                      case 0:
                        return ProfileViewsTab();
                      case 1:
                        //return const InvitesTab();
                        return ProfileViewsTab();
                      case 2:
                        //return const ImpressionsTab();
                        return ProfileViewsTab();
                      default:
                        return ProfileViewsTab();
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProposals(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Proposals',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Obx(() {
              return OutlinedButton(
                onPressed: () {
                  // showBottomSheet(context);
                  showDurationBottomSheet(context, (selectedValue) {
                    controller.selectedDuration.value = selectedValue;
                  });
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      controller.selectedDuration.value,
                      style: TextStyle(color: theme.secondaryHeaderColor),
                    ),
                    const SizedBox(width: 5), // Space between text and icon
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 20,
                      color: theme.secondaryHeaderColor,
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
        const SizedBox(height: 24),
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${controller.stats.value.proposalsSent} proposals sent",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            )),
        const SizedBox(height: 10),
        _buildProposalsSection(),
        const SizedBox(height: 10),
        _buildAvailabilityBadgeInfo(context),
        const SizedBox(height: 10),
        _buildCompleteProfile(context),
        const SizedBox(height: 10),
        const Divider(height: 32),
        _buildClientRelationships(),
        const Divider(height: 32),
        _buildConnectsSection(),
      ],
    );
  }

  Widget _buildAvailabilityBadgeInfo(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: theme.hoverColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.lightbulb_outline, color: Colors.green),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 14, color: theme.hintColor),
                children: [
                  TextSpan(
                      text:
                          'Orbitwork has thousands of available jobs. Browse the ones that best suit you and then send your proposa.'),
                  TextSpan(
                    text: 'Search jobs',
                    style: TextStyle(color: Colors.green),
                  ),
                  // TextSpan(text: ', you can signal to clients that you\'re ready for new work now '),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompleteProfile(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: theme.hoverColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.lightbulb_outline, color: Colors.green),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 14, color: theme.hintColor),
                children: [
                  TextSpan(
                      text:
                      'Freelancers with complete, quality profiles are 4.5 times more likely to get hired by clients.'),
                  TextSpan(
                    text: 'Complete your profile',
                    style: TextStyle(color: Colors.green),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                      Get.bottomSheet(
                          Container(
                            height: Get.height * 0.7,
                              child: CompleteProfileBottomSheet()),
                        isScrollControlled: true,
                        isDismissible: true
                      );
                      },
                  ),
                  // TextSpan(text: ', you can signal to clients that you\'re ready for new work now '),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProposalsSection() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              '${controller.stats.value.proposalsSent} proposals sent',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 24),
            _buildProposalTimeline(),
            SizedBox(height: 16),
            Row(
              children: [
                Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                    shape: BoxShape.circle,
                  ),
                ),
                Text(' Organic'),
                SizedBox(width: 16),
                Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
                Text(' Boosted'),
              ],
            ),
            TextButton(
              onPressed: () {
                Get.toNamed(AppRoutes.myProposalsPage);
              },
              child:
                  Text('My proposals', style: TextStyle(color: Colors.green)),
            ),
          ],
        ));
  }

  Widget _buildProposalTimeline() {
    return Obx(() => Column(
          children: [
            _timelineItem(
                'proposals sent', controller.stats.value.proposalsSent),
            _timelineItem('was viewed', controller.stats.value.proposalsViewed),
            _timelineItem('interviews', controller.stats.value.interviews),
            _timelineItem('hires', controller.stats.value.hires),
          ],
        ));
  }

  Widget _timelineItem(String label, int value) {
    return Row(
      children: [
        Container(
          width: 200,
          height: 4,
          color: value > 0 ? Colors.cyan : Colors.grey.shade300,
        ),
        SizedBox(width: 8),
        Text('$value $label', style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildClientRelationships() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Client relationships',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Client relationships longer than 90 days can positively impact your Job Success Score.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        TextButton(
          onPressed: () {
            Get.bottomSheet(
                ExploreWorkBottomsheet(),
              isScrollControlled: true,
              isDismissible: true
            );
          },
          child: Text(
            'Explore how it works',
            style: TextStyle(
              color: Colors.green[700],
              fontSize: 16,
              decoration: TextDecoration.underline,
              decorationColor: Colors.green[700]
            ),
          ),
        ),
        const SizedBox(height: 24),
        Center(
          child: SizedBox(
            height: 100,
            width: 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Obx(() => Container(
                      height: 80,
                      width: 80,
                      child: CircularProgressIndicator(
                        value: controller.stats.value.clientRelationshipScore /
                            100,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        strokeWidth: 8,
                      ),
                    )),
                Obx(() => Text(
                      '${controller.stats.value.clientRelationshipScore.toInt()}%',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        _buildLegendItem(
          color: Colors.blue,
          text: 'More than 90 days',
        ),
        const SizedBox(height: 8),
        _buildLegendItem(
          color: Colors.cyan[200]!,
          text: 'Less than 90 days',
        ),
      ],
    );
  }

  Widget _buildLegendItem({required Color color, required String text}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.grey[600], fontSize: 16),
        )
      ],
    );
  }

  Widget _buildConnectsSection() {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Obx(() => Text(
                      '${controller.stats.value.connectsLeft}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.copyright_outlined,
                      size: 16,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Connects left',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                OutlinedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.buyMore);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Buy more',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          VerticalDivider(
            thickness: 1,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.blue[700],
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Top Rated',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              //SizedBox(height: 8,),
              TextButton(
                  onPressed: () {
                    Get.bottomSheet(BadgesBottomsheet(),
                    ignoreSafeArea: false,
                    isScrollControlled: true,
                    isDismissible: true);
                  },
                  child: Text(
                    'Earn Top Rated Plus',
                    style: TextStyle(
                        color: Colors.green[700], fontWeight: FontWeight.w500),
                  ))
            ],
          ))
        ],
      ),
    );
  }
}
