import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../comms/url_launcher_helper.dart';
import '../controllers/job_details_controller.dart';
import '../controllers/workroom_timesheet_controller.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_shimmer.dart';

class ViewOffer extends StatelessWidget{
  final TimesheetController controller = Get.put(TimesheetController());
  final JobDetailsController jobDetailsController = Get.put(JobDetailsController());
  @override


  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('View Offer', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _showError(context),
              _buildSeeFullOffer(context),
              Divider(height: 50,),
              _buildClientData(context),
              Divider(height: 50,),
              _buildContract(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showError(BuildContext context){
    final theme = Theme.of(context);
    return Container(
        decoration: BoxDecoration(
            color: Colors.yellow.shade50,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.error_outline),
              const SizedBox( width:  5.0,),
              Expanded(
                child: RichText(text: TextSpan(
                    style: TextStyle(color: theme.secondaryHeaderColor,
                        height: 1.5),
                    children: [
                      TextSpan(
                          text: 'You accepted this offer on Sep 26, 2024. '
                      ),
                      TextSpan(text: 'View the contract', style: TextStyle(
                        decoration: TextDecoration.underline,
                      )),
                      TextSpan(text: ' for more details.')
                    ]
                )),
              ),
            ],
          ),
        )
    );
  }

  Widget _buildContractDetails(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contract details', style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w500
        ),),
        _buildContractDetailRow('Status', controller.status, isGreen: true),
        _buildDivider(),
        _buildContractDetailRow('Start date', controller.startDate),
        _buildDivider(),
        _buildContractDetailRow('Hourly rate', controller.hourlyrate),
        _buildDivider(),
        _buildContractDetailRow('Rate increase', controller.rateIncrease),
        _buildDivider(),
        _buildContractDetailRow('Weekly limit', controller.weeklyLimit),
        _buildDivider(),
        _buildContractDetailRow('Job category', controller.jobCategory),
        _buildDivider(),
        _buildContractDetailRow('Offer date', controller.offerDate),
        _buildDivider(),
        _buildContractDetailRow('Offer expires', controller.offerExpires),
        _buildDivider(),
        _buildContractDetailRow('Manual time allowed', controller.manualTimeAllowed),
        _buildDivider(),
        SizedBox(height: 10,)
      ],
    );
  }

  Widget _buildContractDetailRow(String label, Rx<String> value, {bool isGreen = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Obx(() => Text(
              value.value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isGreen ? Colors.green : Colors.black,
              ),
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey[300],
      height: 1,
    );
  }

  Widget _buildSeeFullOffer(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          Text(
            'Backend Dev work with ${controller.userName}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 16),

          // Show contract details only if isOfferExpanded is true
          Obx(() => controller.isOfferExpanded.value ? _buildContractDetails() : SizedBox()),

          SizedBox(
            width: Get.width,
            child: OutlinedButton(
              onPressed: () {
                // Toggle the visibility of contract details
                controller.isOfferExpanded.value = !controller.isOfferExpanded.value;
              },
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                side: BorderSide(color: Colors.grey, width: 2),
                foregroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Obx(() => Text(
                controller.isOfferExpanded.value ? 'See less' : 'See full offer',
                style: TextStyle(color: theme.primaryColor),
              )),
            ),
          ),

          SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text('How do hourly contracts work?')),
                      Obx(() => IconButton(
                        onPressed: () {
                          controller.isExpanded.value = !controller.isExpanded.value;
                        },
                        icon: Icon(
                          controller.isExpanded.value
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                        ),
                      )),
                    ],
                  ),
                  Obx(() {
                    return controller.isExpanded.value
                        ? Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      color: theme.secondaryHeaderColor, height: 1.5),
                                  children: [
                                    TextSpan(text: 'Hourly contracts may be covered by '),
                                    TextSpan(
                                        text: 'Orbitwork Hourly Protection.',
                                        style: TextStyle(
                                            decoration: TextDecoration.underline,
                                            color: theme.primaryColor,
                                            decorationColor: theme.primaryColor)),
                                    TextSpan(
                                        text:
                                        ' Your client is automatically invoiced and billed for the hours you log according to the '),
                                    TextSpan(
                                        text: 'weekly billing cycle.',
                                        style: TextStyle(
                                            decoration: TextDecoration.underline,
                                            color: theme.primaryColor,
                                            decorationColor: theme.primaryColor)),
                                  ])),
                          SizedBox(height: 16),
                          Text(
                              'However, if you log time over the weekly limit you and your client originally agreed to, it won\'t be invoiced to your client, but they can see it in your Work Diary. You can negotiate a bonus payment for that time, if your client agrees.'),
                          SizedBox(height: 16),
                          GestureDetector(
                            onTap: () => UrlLauncherHelper.openUrl('https://www.google.com'),
                            child: Text(
                              'Learn more about hourly contracts',
                              style: TextStyle(
                                  color: theme.primaryColor,
                                  decoration: TextDecoration.underline,
                                  decorationColor: theme.primaryColor),
                            ),
                          ),
                        ],
                      ),
                    )
                        : SizedBox();
                  })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


  String _getShortUserRole(String role) {
    return role.contains(' ') ? '${role.split(' ').first} A.' : role;
  }

  String _getFormattedUserRole(String role) {
    return role.replaceAll(' ', '');
  }

  Widget _buildClientData(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person_outline),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(
                  _getShortUserRole(controller.userRole.value),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                )),
                Row(
                  children: [
                    Obx(() => Text(
                      _getFormattedUserRole(controller.userRole.value),
                    )),
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            controller.isAboutClientExpanded.value =
            !controller.isAboutClientExpanded.value;
          },
          child: Row(
            children: [
              Text('About the client', style: TextStyle(color: Colors.green)),
              Obx(() => Icon(
                controller.isAboutClientExpanded.value
                    ? Icons.keyboard_arrow_up_sharp
                    : Icons.keyboard_arrow_down_sharp,
                color: Colors.green,
              )),
            ],
          ),
        ),
        SizedBox(height: 16),
        Obx(() => controller.isAboutClientExpanded.value
            ? _buildAboutTheClient(context)
            : SizedBox.shrink()),
        SizedBox(height: 16),
        SizedBox(
          width: Get.width,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              side: BorderSide(color: Colors.grey, width: 2),
              foregroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('Chat with Cofounderslab',
                style: TextStyle(color: theme.primaryColor)),
          ),
        ),
      ],
    );
  }


  Widget _buildContract(){
    return Container(
      width: Get.width,
      decoration: BoxDecoration(color: Colors.grey.shade100,
     borderRadius: BorderRadius.circular(8)
      ),
      padding: EdgeInsets.all(16),
      child:  OutlinedButton(onPressed: () {
        Get.toNamed(AppRoutes.contractDetails, arguments: true);
      },
          style: OutlinedButton.styleFrom(
            padding:
            EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            backgroundColor: Colors.white,
            side: BorderSide(color: Colors.green, width: 2),
            foregroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text('View contract', style: TextStyle(color: Colors.green),)),
    );
  }

  Widget _buildAboutTheClient(BuildContext context){
    final formatter =
    NumberFormat.compact(locale: "en_US", explicitSign: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About the client',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.verified, color: Colors.green),
            SizedBox(width: 8),
            Text('Payment method verified'),
          ],
        ),
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber),
            Icon(Icons.star, color: Colors.amber),
            Icon(Icons.star, color: Colors.amber),
            Icon(Icons.star, color: Colors.amber),
            Icon(Icons.star, color: Colors.amber),
            Text(' 5.0'),
          ],
        ),
        Text(' (496 of 67 reviews)'),
        SizedBox(height: 16),
        Obx(
                () {if (jobDetailsController.isLoading.value) {
              return Column(
                children: List.generate(
                  6,
                      (index) => Padding(
                    padding:
                    const EdgeInsets.only(bottom: 16.0),
                    child: CustomShimmer(width: MediaQuery.of(context).size.width *0.4, height: 20,),
                  ),
                ),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${jobDetailsController.jobDetails.value?.country}'),
                Text(
                    '${jobDetailsController.jobDetails.value?.city} ${jobDetailsController.jobDetails.value?.time}'),
                SizedBox(height: 16),
                Text(
                    '${jobDetailsController.jobDetails.value?.jobsPosted} jobs posted'),
                Text(
                    '${jobDetailsController.jobDetails.value?.hireRate}% hire Rate, ${jobDetailsController.jobDetails.value?.openJobs} open jobs'),
                SizedBox(height: 16),
                Text(
                    '\$${formatter.format(jobDetailsController.jobDetails.value?.totalSpent ?? 0)} total spent'),
                Text(
                    '${jobDetailsController.jobDetails.value?.hirers} hires, ${jobDetailsController.jobDetails.value?.activeHirers} active'),
                SizedBox(height: 16),
                Text(
                    '\$${jobDetailsController.jobDetails.value?.avgHourlyRate.toStringAsFixed(2)}/hr avg hourly rate paid'),
                Text(
                    '${jobDetailsController.jobDetails.value?.hours} hours'),
                SizedBox(height: 16),
                Text(jobDetailsController.jobDetails.value?.industry ??
                    ''),
                Text('Individual client'),
                SizedBox(height: 16),
                Text(
                    'Member since ${jobDetailsController.jobDetails.value?.sinceDate}')
              ],
            );
            }
        ),
      ],
    );
  }
}