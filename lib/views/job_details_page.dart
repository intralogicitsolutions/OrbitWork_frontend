import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:orbitwork/comms/global/global_tooltip.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:ui' as ui;
import '../component/flag_inappropriate_bottomsheet.dart';
import '../controllers/buy_connects_controller.dart';
import '../controllers/clients_history_controller.dart';
import '../controllers/job_details_controller.dart';
import '../controllers/jobs_controller.dart';
import '../controllers/profile_setting_controller.dart';
import '../models/job_model.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_shimmer.dart';

class JobDetailsView extends StatelessWidget {
  final Job job;
  final JobsController jobscontroller = Get.find();
  final JobDetailsController controller = Get.put(JobDetailsController());
  final ClientsHistoryController jobController =
      Get.put(ClientsHistoryController());
  final ProfileController profileController = Get.put(ProfileController());
  final BuyConnectsController buyConnectsController = Get.put(BuyConnectsController());

  JobDetailsView({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formatter =
        NumberFormat.compact(locale: "en_US", explicitSign: false);
    controller.fetchJobs();
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child:
          // if (controller.isLoading.value) {
          //   return _buildShimmerEffect();
          // }
           Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Obx(
                               () {
                                 if (controller.isLoading.value) {
                                   return CustomShimmer(
                                     width: MediaQuery.of(context).size.width *0.7,
                                     height: 20,
                                   );
                                 }
                                return Expanded(
                                  child: Text(
                                    job.title,
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                );
                              }
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Obx(() {
                              return Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: theme.dividerColor,
                                    width: 1, // Border thickness
                                  ),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    jobscontroller.favoriteJobs.contains(job)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    //color: Colors.black,
                                    color: Theme.of(context).iconTheme.color,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    jobscontroller.toggleFavorite(job);
                                  },
                                ),
                              );
                            }),
                          ],
                        ),
                        SizedBox(height: 8),
                        Obx(
                          () {
                            if (controller.isLoading.value) {
                              return CustomShimmer(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 20,
                              );
                            }
                            return Text(
                              "Posted ${job.postedTimeAgo} ago",
                            );
                          }
                        ),
                        SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/icon/speaker.png',
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                               Expanded(child: RichText(text: TextSpan(
                                 style: TextStyle(
                                   color: Get.theme.secondaryHeaderColor, height: 1.5
                                 ),
                                 children: [
                                   TextSpan(
                                     text: 'Specialized profiles can help you better highlight your expertise when submitting proposals to jobs like these.'
                                   ),
                                   TextSpan(
                                     text: 'Create a specialized profile', style: TextStyle(
                                     color: Get.theme.primaryColor, decoration: TextDecoration.underline,
                                     decorationColor: Get.theme.primaryColor,
                                   ),
                                     recognizer: TapGestureRecognizer()
                                       ..onTap = () {
                                         profileController.addSpecializedProfile(); // Call the controller method
                                       },
                                   )
                                 ]
                               ))),

                          ],
                        ),

                        SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/icon/location.png',
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Worldwide'),
                          ],
                        ),
                        SizedBox(height: 16),

                        // Proposal and Connect Details
                        Obx(
                          () {
                            if (controller.isLoading.value) {
                              return Column(
                                children: [
                                  CustomShimmer(
                                    width: MediaQuery.of(context).size.width *0.7,
                                    height: 20,
                                  ),
                                ],
                              );
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Send a proposal: ${controller.jobDetails.value?.connects} Connects'),
                                Text(
                                    'Available Connects: ${controller.jobDetails.value?.availableConnects}'),
                              ],
                            );
                          }
                        ),
                        SizedBox(height: 16),

                        Obx(
                           () {
                             if (controller.isLoading.value) {
                               return CustomShimmer(
                                 width: MediaQuery.of(context).size.width *0.7,
                                 height: 20,
                               );
                             }
                            return Text(job.description);
                          }
                        ),

                        SizedBox(height: 16),
                        // Price and Experience Level
                        _priceAndExperience(
                            Icons.monetization_on_outlined,
                            job.isFixedPrice
                                ? '\$${job.budget.toStringAsFixed(2)}'
                                : '\$${job.hourlyRateMin} - \$${job.hourlyRateMax}',
                            job.isFixedPrice ? 'Fixed-price' : 'Hourly',context),
                        SizedBox(height: 16),

                        !job.isFixedPrice
                            ? _priceAndExperience(Icons.access_time_sharp,
                                '${job.hoursPerWeek} hrs/week', 'Hourly',context)
                            : SizedBox.shrink(),
                        !job.isFixedPrice
                            ? SizedBox(height: 16)
                            : SizedBox.shrink(),

                        !job.isFixedPrice
                            ? _priceAndExperience(Icons.calendar_today_outlined,
                                '${job.estimatedTime}', 'Duration',context)
                            : SizedBox.shrink(),
                        !job.isFixedPrice
                            ? SizedBox(height: 16)
                            : SizedBox.shrink(),

                        _priceAndExperience(
                            Icons.miscellaneous_services_outlined,
                            '${job.jobType}',
                            'Experience Level',context),

                        SizedBox(height: 24),

                        Text('Attachment',  style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),),
                        Row(
                          children: [
                            Icon(Icons.attach_file, size: 20,),
                            SizedBox(width: 2,),
                            Obx(
                               () {
                                 if (controller.isLoading.value) {
                                   return CustomShimmer(
                                     width: MediaQuery.of(context).size.width *0.4,
                                     height: 20,
                                   );
                                 }
                                return Text(
                                  '${controller.jobDetails.value?.attachmentFileName}(${controller.jobDetails.value?.attachmentFileSize.toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '') ?? '0'}MB)',
                                  style: TextStyle(
                                    color: Colors.green,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.green,
                                    decorationThickness: 1.5,
                                  ),
                                );
                              }
                            ),
                          ],
                        ),

                        SizedBox(height: 24,),

                        Row(
                          children: [
                            Text(
                              'Project Type: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Obx(
                              () {
                                if (controller.isLoading.value) {
                                  return CustomShimmer(
                                    width: MediaQuery.of(context).size.width *0.4,
                                    height: 20,
                                  );
                                }
                                return Text(
                                    controller.jobDetails.value?.projectType ?? '');
                              }
                            ),
                          ],
                        ),
                        SizedBox(height: 16),

                        // Skills and Expertise Section
                        Text(
                          'Skills and Expertise',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Obx(
                          () {
                            if (controller.isLoading.value) {
                              return CustomShimmer(
                                width: MediaQuery.of(context).size.width,
                                height: 20,
                              );
                            }
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: job.tags
                                    .map((tag) => Container(
                                          margin: const EdgeInsets.only(right: 8),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 6),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            // color: Theme.of(context)
                                            //     .chipTheme
                                            //     .backgroundColor,
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          child: Text(
                                            tag,
                                            // style: Theme.of(context)
                                            //     .chipTheme
                                            //     .labelStyle
                                            //     ?.copyWith(fontSize: 12),
                                            style: TextStyle(
                                                fontSize: 12, color: Colors.black),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            );
                          }
                        ),
                        // Wrap(
                        //   spacing: 8.0,
                        //   children: [
                        //     Chip(
                        //       label: Text('React'),
                        //       backgroundColor: Colors.grey.shade200,
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(20),
                        //       ),
                        //       side: BorderSide.none,
                        //     ),
                        //     Chip(
                        //       label: Text('Clerk'),
                        //       backgroundColor: Colors.grey.shade200,
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(20),
                        //       ),
                        //       side: BorderSide.none,
                        //     ),
                        //   ],
                        // ),
                        SizedBox(height: 16),

                        // Activity on This Job Section
                        Text(
                          'Activity on this job',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Proposals: '),
                                Row(
                                  children: [
                                    GlobalTooltip(text: 'This range includes relevant proposals, but does not include proposals, but does not include proposals that are withdrawn, declined or archived. Please note that all proposals are accessible to clients on their applicants page.',
                                    iconColor: Get.theme.primaryColor,
                                    iconSize: 16,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text('Less than 5'),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Last viewed by client: '),
                                Row(
                                  children: [
                                    GlobalTooltip(text: 'This is when the client last reviewed or interacted with the applicants for this job.',
                                    iconSize: 16,
                                      iconColor: Get.theme.primaryColor,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text('43 minutes ago'),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Interviewing: '),
                                Text(
                                  '0',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Invites sent: '),
                                Text(
                                  '0',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Unanswered invites: '),
                                Text('0',
                                    style: TextStyle(color: Colors.green)),
                              ],
                            ),
                          ],
                        ),
                        !job.isFixedPrice ? SizedBox(height: 16) : SizedBox.shrink(),

                        !job.isFixedPrice ? Text('Bid range - High \$40.00 | Avg \$24.63 | Low \$15.00',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ): SizedBox.shrink(),

                        SizedBox(height: 24,),

                        // About the Client Section
                        Text(
                          'About the client',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                               () {if (controller.isLoading.value) {
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
                                    Text('${controller.jobDetails.value?.country}'),
                                    Text(
                                        '${controller.jobDetails.value?.city} ${controller.jobDetails.value?.time}'),
                                    SizedBox(height: 16),
                                    Text(
                                        '${controller.jobDetails.value?.jobsPosted} jobs posted'),
                                    Text(
                                        '${controller.jobDetails.value?.hireRate}% hire Rate, ${controller.jobDetails.value?.openJobs} open jobs'),
                                    SizedBox(height: 16),
                                    Text(
                                        '\$${formatter.format(controller.jobDetails.value?.totalSpent ?? 0)} total spent'),
                                    Text(
                                        '${controller.jobDetails.value?.hirers} hires, ${controller.jobDetails.value?.activeHirers} active'),
                                    SizedBox(height: 16),
                                    Text(
                                        '\$${controller.jobDetails.value?.avgHourlyRate.toStringAsFixed(2)}/hr avg hourly rate paid'),
                                    Text(
                                        '${controller.jobDetails.value?.hours} hours'),
                                    SizedBox(height: 16),
                                    Text(controller.jobDetails.value?.industry ??
                                        ''),
                                    Text('Individual client'),
                                    SizedBox(height: 16),
                                    Text(
                                        'Member since ${controller.jobDetails.value?.sinceDate}')
                                  ],
                                );
                              }
                            ),
                            const SizedBox(height: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Client's Recent History Section
                                Obx(() {
                                  final remainingHistory =
                                      jobController.recentHistory.length -
                                          jobController.displayLimit.value;
                                  final displayedHistory = jobController
                                      .recentHistory
                                      .take(jobController.displayLimit.value)
                                      .toList();
                                  // final jobsInProgress = jobController.recentHistory;
                                  // final remainingJobs = jobsInProgress.length - jobController.displayLimit.value;
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Client\'s recent history (${jobController.recentHistory.length})',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          GestureDetector(
                                            onTap: () =>
                                                jobController.toggleExpanded(),
                                            child: Container(
                                              height: 30,
                                              child: Chip(
                                                visualDensity:
                                                    const VisualDensity(
                                                        horizontal: 0.0,
                                                        vertical: -4),
                                                label: Icon(jobController
                                                        .isExpanded.value
                                                    ? Icons.keyboard_arrow_up
                                                    : Icons
                                                        .keyboard_arrow_down, color: theme.secondaryHeaderColor,),
                                                backgroundColor:
                                                    Colors.grey.shade200,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                side: BorderSide.none,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      if (jobController.isExpanded.value)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ...displayedHistory.map((job) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 20,),
                                                  Text(
                                                    '${job['title']}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      StarRating(
                                                          rating: double.parse(
                                                              job['rating']
                                                                  .toString())),
                                                      SizedBox(width: 10),
                                                      Text(
                                                        job['rating']
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text('To freelancer: ${job['freelancer']}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),),
                                                  SizedBox(height: 5,),
                                                  Text('May 2023 - Jul 2024'),
                                                  Text('${job['hours']} hrs @ \$${job['rate']}/hr', style: TextStyle(fontWeight: FontWeight.w500),),
                                                  Text('Billed: ${job['billed']}'),
                                                  // Text(
                                                  //   'To freelancer: ${job['freelancer']}\n\nMay 2023 - Jul 2024'
                                                  //   '\n${job['hours']} hrs @ \$${job['rate']}/hr'
                                                  //   '\nBilled: ${job['billed']}',
                                                  //   style: TextStyle(
                                                  //       color: Colors.black),
                                                  // ),
                                                ],
                                              );
                                            }).toList(),
                                            if (remainingHistory > 0)
                                              TextButton(
                                                onPressed: () {
                                                  jobController
                                                      .increaseDisplayLimit();
                                                },
                                                child: Text(
                                                  'View More ($remainingHistory )',
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                ),
                                              ),
                                            if (remainingHistory <= 0 &&
                                                jobController
                                                        .recentHistory.length >
                                                    5)
                                              TextButton(
                                                onPressed: () {
                                                  jobController
                                                      .resetDisplayLimit();
                                                  jobController
                                                      .isExpanded.value = false;
                                                },
                                                child: Text(
                                                  'View Less',
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                ),
                                              ),
                                          ],
                                        ),
                                    ],
                                  );
                                }),
                                const SizedBox(height: 10),

                                Obx(() {
                                  final jobsInProgress =
                                      jobController.jobsInProgress;
                                  final remainingJobs = jobsInProgress.length -
                                      jobController.displayLimit.value;
                                  final displayedJobs = jobsInProgress
                                      .take(jobController.displayLimit.value)
                                      .toList();
                                  // if (!jobController.isJobsExpanded.value) {
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Jobs in progress (${jobController.jobsInProgress.length})',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          GestureDetector(
                                            onTap: () => jobController
                                                .toggleJobsExpanded(),
                                            child: Container(
                                              height: 30,
                                              child: Chip(
                                                visualDensity:
                                                    const VisualDensity(
                                                        horizontal: 0.0,
                                                        vertical: -4),
                                                label: Icon(jobController
                                                        .isJobsExpanded.value
                                                    ? Icons.keyboard_arrow_up
                                                    : Icons
                                                        .keyboard_arrow_down,  color: theme.secondaryHeaderColor,),
                                                backgroundColor:
                                                    Colors.grey.shade200,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                side: BorderSide.none,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (jobController.isJobsExpanded.value)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // ListTile(
                                            //   title: Text(
                                            //     'Jobs in progress',
                                            //     style: TextStyle(
                                            //         fontSize: 16,
                                            //         fontWeight: FontWeight.w500),
                                            //   ),
                                            //   trailing:
                                            //       Icon(Icons.keyboard_arrow_up),
                                            //   onTap: () => jobController
                                            //       .toggleJobsExpanded(),
                                            // ),
                                            ...displayedJobs.map((job) {
                                              return ListTile(
                                                title: Text('${job['title']}', style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    fontSize: 16),),
                                                subtitle: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: 5),
                                                    Text('To freelancer: ${job['freelancer']}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),),
                                                    SizedBox(height: 5,),
                                                    Text('May 2023 - Jul 2024'),
                                                    Text('${job['hours']} hrs @ \$${job['rate']}/hr', style: TextStyle(fontWeight: FontWeight.w500),),
                                                    Text('Billed: ${job['billed']}'),
                                                    // Text(
                                                    //   'To freelancer: ${job['freelancer']}\nMay 2023 - Jul 2024'
                                                    //   '\n${job['hours']} hrs @ \$${job['rate']}/hr'
                                                    //   '\nBilled: ${job['billed']}',
                                                    // ),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                            if (remainingJobs > 0)
                                              TextButton(
                                                onPressed: () {
                                                  jobController
                                                      .increaseDisplayLimit();
                                                },
                                                child: Text(
                                                  'View More ($remainingJobs)',
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                ),
                                              ),
                                            if (remainingJobs <= 0 &&
                                                jobsInProgress.length > 5)
                                              TextButton(
                                                onPressed: () {
                                                  jobController
                                                      .resetDisplayLimit();
                                                  jobController.isJobsExpanded
                                                      .value = false;
                                                },
                                                child: Text(
                                                  'View Less',
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                ),
                                              ),
                                          ],
                                        ),
                                    ],
                                  );
                                }),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Obx(() {
                              // Display loading spinner while data is being fetched
                              if (controller.jobs.isEmpty) {
                                return Column(
                                  children: List.generate(
                                    5,
                                    (index) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16.0),
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              height: 16.0,
                                              color: Colors.grey[300],
                                            ),
                                            const SizedBox(height: 8),
                                            Container(
                                              width: 100.0,
                                              height: 12.0,
                                              color: Colors.grey[300],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }

                              final displayedJobs = controller.showAllJobs.value
                                  ? controller.jobs
                                  : controller.initialJobs;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Other open jobs by this Client (${controller.jobs.length})',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ...displayedJobs.map((job) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              job['title']!,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.green,
                                              ),
                                            ),
                                            Text(
                                              job['type']!,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black54),
                                            ),
                                            const SizedBox(height: 8),
                                          ],
                                        );
                                      }).toList(),
                                      const SizedBox(height: 16),
                                      Row(
                                        children: [
                                          // View More button
                                          if (!controller.showAllJobs.value)
                                            GestureDetector(
                                              onTap: () => controller
                                                  .toggleShowAll(true),
                                              child: const Text(
                                                'View More',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                          if (!controller.showAllJobs.value)
                                            const SizedBox(width: 16),
                                          if (controller.showAllJobs.value)
                                            GestureDetector(
                                              onTap: () => controller
                                                  .toggleShowAll(false),
                                              child: const Text(
                                                'View Less',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(
                                  Icons.flag,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.bottomSheet(
                                      Container(
                                          height: Get.height * 0.8,
                                          child: FlagInappropriateBottomsheet()),
                                      isScrollControlled: true,
                                      ignoreSafeArea: false,
                                    );
                                  },
                                  child: Text(
                                    'Flag as inappropriate',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Footer Section
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(() {
                          return CustomButton(
                            buyConnectsController.hasBoughtConnects.value ?
                            'Apply now':
                            'Buy Connects to apply',
                            onPressed: () {
                              if (buyConnectsController.hasBoughtConnects.value) {
                                Get.toNamed(AppRoutes.submitProposal);
                              } else {
                                Get.toNamed(AppRoutes.buyConnects);
                              }
                              //Get.toNamed(AppRoutes.submitProposal);
                              //Get.toNamed(AppRoutes.buyConnects);
                            },
                          );
                        }
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {jobscontroller.toggleFavorite(job);},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.scaffoldBackgroundColor,
                          // padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          // Remove extra padding
                          minimumSize: Size(0, 0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(() {
                              return IconButton(
                                icon: Icon(
                                  jobscontroller.favoriteJobs.contains(job)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  //color: Colors.black,
                                  color: Theme.of(context).iconTheme.color,
                                  size: 20,
                                ),
                                onPressed: () {
                                  jobscontroller.toggleFavorite(job);
                                },
                              );
                            }),
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Text(
                                'Save job',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

      ),
    );
  }

  Widget _priceAndExperience(IconData icon, String textdata, String text, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon),
        SizedBox(
          width: 5,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
             () {
               if (controller.isLoading.value) {
                 return CustomShimmer(
                   width: MediaQuery.of(context).size.width *0.3,
                   height: 20,
                 );
               }
                return Text(textdata, style: TextStyle(fontWeight: FontWeight.bold));
              }
            ),
            Text(text),
          ],
        ),
      ],
    );
  }
}

class StarRating extends StatelessWidget {
  final double rating; // Example: 4.8

  StarRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return Icon(Icons.star, color: Colors.amber);
        } else if (index < rating) {
          return Icon(Icons.star_half, color: Colors.amber);
        } else {
          return Icon(Icons.star_border, color: Colors.amber);
        }
      }),
    );
  }
}
