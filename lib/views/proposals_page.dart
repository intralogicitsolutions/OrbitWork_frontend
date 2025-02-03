import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/proposal_controller.dart';
import '../component/select_setting_bottomsheet.dart';
import '../models/chip_data.dart';
import '../widgets/custom_appbar.dart';

class ProposalsPage extends StatelessWidget {
  final ProposalController controller = Get.put(ProposalController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
      title: "My Proposals",
      rightIcon: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: theme.dividerColor,
            // color: Colors.black,
            width: 1,
          ),
        ),
        child: IconButton(
          icon: Icon(Icons.settings, size: 15,color: theme.primaryColor,),
          onPressed: () {
            Get.bottomSheet(
              BadgeBottomSheet(),
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
            );
          },
        ),
      ),
    ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //_buildHeader(),
            _buildTabs(),
            _buildStatusChips(),
            // Expanded(child: _buildProposalsList()),
            Expanded(
              child: Obx(() {
                if (controller.selectedTab.value == 'Referrals' &&
                    controller.referralProposals.isEmpty) {
                  return _buildEmptyState(context);
                }
                return _buildProposalsList();
              }),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildHeader() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             CircleAvatar(
  //               radius: 20,
  //               backgroundColor: Colors.grey[300],
  //             ),
  //             Container(
  //               padding: EdgeInsets.all(8),
  //               decoration: BoxDecoration(
  //                 shape: BoxShape.circle,
  //                 color: Colors.grey[100],
  //               ),
  //               child: Icon(Icons.settings, size: 20, color: Colors.grey[700]),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 16),
  //         Text(
  //           'My proposals',
  //           style: TextStyle(
  //             fontSize: 28,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildTabs() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!, width: 1),
        ),
      ),
      child: Obx(() => Row(
            children: ['Active', 'Referrals', 'Archived'].map((tab) {
              final isSelected = controller.selectedTab.value == tab;
              return GestureDetector(
                onTap: () => controller.changeTab(tab),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isSelected ? Colors.black : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text(
                    tab,
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.grey[600],
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            }).toList(),
          )),
    );
  }

  Widget _buildStatusChips() {
    return Obx(() {
      final chips = controller.getChipsForCurrentTab();
      return Container(
        height: 56,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              ...chips.map((chip) => _buildChip(chip)).toList(),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildChip(ChipData chipData) {
    return Obx(() {
      final isSelected = controller.selectedChip.value == chipData.label;
      return Container(
        margin: EdgeInsets.only(right: 8),
        child: FilterChip(
          showCheckmark: false,
          label: Text(
            chipData.displayText,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.grey[700],
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
          selected: isSelected,
          onSelected: (bool selected) {
            controller.selectChip(selected ? chipData.label : '');
          },
          backgroundColor: Colors.grey[200],
          selectedColor: Colors.grey[200],
          side: BorderSide(
            color: isSelected ? Colors.black : Colors.grey[400]!,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        ),
      );
    });
  }

  Widget _buildProposalsList() {
    return Obx(() => ListView.separated(
          itemCount: controller.getCurrentProposals().length,
          separatorBuilder: (context, index) => Divider(
            height: 1,
            color: Colors.grey[300],
          ),
          itemBuilder: (context, index) {
            final proposal = controller.getCurrentProposals()[index];
            return Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          proposal.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        _formatDate(proposal.date),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  if (proposal.viewedByClient ?? false) ...[
                    Row(
                      children: [
                        Icon(Icons.visibility_outlined,
                            size: 16, color: Colors.grey[600]),
                        SizedBox(width: 4),
                        Text(
                          'Viewed by client',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                  SizedBox(height: 4),
                  if (proposal.isJobClosed ?? false)
                    Text(
                      'Job is closed',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'Proposal sent with ${proposal.profileType}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You haven\'t been referred yet', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
            Text(
                'When declinning an invitation, you can make a referral to help other freelancers suceed and help clients fill their job',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () {
                // Button action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                // backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Learn about referring freelancers',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
