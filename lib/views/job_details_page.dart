import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/clients_history_controller.dart';
import '../controllers/job_details_controller.dart';
import '../controllers/jobs_controller.dart';
import '../models/job_model.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_button.dart';

class JobDetailsView extends StatelessWidget {
  final Job job;
  final JobsController jobscontroller = Get.find();
  final JobDetailsController controller = Get.put(JobDetailsController());
  final ClientsHistoryController jobController =
      Get.put(ClientsHistoryController());

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
      body: Column(
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
                        Expanded(
                          child: Text(
                            controller.jobDetails.title,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
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
                    Text(controller.jobDetails.description),
                    SizedBox(height: 16),
                    Text(
                      controller.jobDetails.expertise,
                      style: TextStyle(color: Colors.green),
                    ),
                    SizedBox(height: 8),
                    Text('${controller.jobDetails.location}'),
                    SizedBox(height: 16),

                    // Proposal and Connect Details
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Send a proposal: ${controller.jobDetails.connects} Connects'),
                        Text(
                            'Available Connects: ${controller.jobDetails.availableConnects}'),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Price and Experience Level
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.monetization_on_outlined),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '\$${controller.jobDetails.price.toStringAsFixed(2)}',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Fixed-price'),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.miscellaneous_services_outlined),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${controller.jobDetails.experienceLevel}',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Experience Level'),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          'Project Type: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(controller.jobDetails.projectType),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Skills and Expertise Section
                    Text(
                      'Skills and Expertise',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0,
                      children: [
                        Chip(
                          label: Text('React'),
                          backgroundColor: Colors.grey.shade200,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          side: BorderSide.none,
                        ),
                        Chip(
                          label: Text('Clerk'),
                          backgroundColor: Colors.grey.shade200,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          side: BorderSide.none,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Activity on This Job Section
                    Text(
                      'Activity on this job',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                                Icon(
                                  Icons.help_outline,
                                  size: 16,
                                  color: Colors.green,
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
                            Text('0', style: TextStyle(color: Colors.green)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // About the Client Section
                    Text(
                      'About the client',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ukraine'),
                            Text('Tokmak ${controller.jobDetails.tokmakTime}'),
                            SizedBox(height: 16),
                            Text(
                                '${controller.jobDetails.jobsPosted} jobs posted'),
                            Text(
                                '${controller.jobDetails.hireRate}% hire Rate, ${controller.jobDetails.openJobs} open jobs'),
                            SizedBox(height: 16),
                            Text(
                                '\$${formatter.format(controller.jobDetails.totalSpent)} total spent'),
                            Text(
                                '${controller.jobDetails.hirers} hires, ${controller.jobDetails.activeHirers} active'),
                            SizedBox(height: 16),
                            Text(
                                '\$${controller.jobDetails.avgHourlyRate.toStringAsFixed(2)}/hr avg hourly rate paid'),
                            Text('${controller.jobDetails.hours} hours'),
                            SizedBox(height: 16),
                            Text(controller.jobDetails.industry),
                            Text('Individual client'),
                            SizedBox(height: 16),
                            Text(
                                'Member since ${controller.jobDetails.sinceDate}')
                          ],
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                            visualDensity: const VisualDensity(
                                                horizontal: 0.0, vertical: -4),
                                            label: Icon(jobController
                                                    .isExpanded.value
                                                ? Icons.keyboard_arrow_up
                                                : Icons.keyboard_arrow_down),
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
                                              Text(
                                                '${job['title']}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
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
                                                    job['rating'].toString(),
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                'To freelancer: ${job['freelancer']}\n\nMay 2023 - Jul 2024'
                                                '\n${job['hours']} hrs @ \$${job['rate']}/hr'
                                                '\nBilled: ${job['billed']}',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
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
                                            jobController.recentHistory.length >
                                                5)
                                          TextButton(
                                            onPressed: () {
                                              jobController.resetDisplayLimit();
                                              jobController.isExpanded.value =
                                                  false;
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
                                        'Jobs in progress',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      GestureDetector(
                                        onTap: () =>
                                            jobController.toggleJobsExpanded(),
                                        child: Container(
                                          height: 30,
                                          child: Chip(
                                            visualDensity: const VisualDensity(
                                                horizontal: 0.0, vertical: -4),
                                            label:
                                                 Icon(jobController
                                                        .isJobsExpanded.value
                                                    ? Icons.keyboard_arrow_up
                                                    : Icons.keyboard_arrow_down),

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
                                            title: Text('${job['title']}'),
                                            subtitle: Text(
                                              'To freelancer: ${job['freelancer']}\nMay 2023 - Jul 2024'
                                                  '\n${job['hours']} hrs @ \$${job['rate']}/hr'
                                                  '\nBilled: ${job['billed']}',),
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
                                              jobController.resetDisplayLimit();
                                              jobController
                                                  .isJobsExpanded.value = false;
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
                              // return ListTile(
                              //   title: Text(
                              //     'Jobs in progress',
                              //     style: TextStyle(
                              //         fontSize: 16,
                              //         fontWeight: FontWeight.w500),
                              //   ),
                              //   trailing: Icon(Icons.keyboard_arrow_down),
                              //   onTap: () =>
                              //       jobController.toggleJobsExpanded(),
                              // );

                              //}

                              // return Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     ListTile(
                              //       title: Text(
                              //         'Jobs in progress',
                              //         style: TextStyle(
                              //             fontSize: 16,
                              //             fontWeight: FontWeight.w500),
                              //       ),
                              //       trailing: Icon(Icons.keyboard_arrow_up),
                              //       onTap: () =>
                              //           jobController.toggleJobsExpanded(),
                              //     ),
                              //     ...displayedJobs.map((job) {
                              //       return ListTile(
                              //         title: Text('${job['title']}'),
                              //         subtitle: Text(
                              //             'To freelancer: ${job['freelancer']}'),
                              //       );
                              //     }).toList(),
                              //     if (remainingJobs > 0)
                              //       TextButton(
                              //         onPressed: () {
                              //           jobController.increaseDisplayLimit();
                              //         },
                              //         child: Text(
                              //           'View More ($remainingJobs)',
                              //           style: TextStyle(color: Colors.green),
                              //         ),
                              //       ),
                              //     if (remainingJobs <= 0 &&
                              //         jobsInProgress.length > 5)
                              //       TextButton(
                              //         onPressed: () {
                              //           jobController.resetDisplayLimit();
                              //           jobController.isJobsExpanded.value =
                              //               false;
                              //         },
                              //         child: Text(
                              //           'View Less',
                              //           style: TextStyle(color: Colors.green),
                              //         ),
                              //       ),
                              //   ],
                              // );
                            }),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Obx(() {
                          // Display loading spinner while data is being fetched
                          if (controller.jobs.isEmpty) {
                            return const Center(
                                child: CircularProgressIndicator());
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
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          onTap: () =>
                                              controller.toggleShowAll(true),
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
                                          onTap: () =>
                                              controller.toggleShowAll(false),
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
                            Icon(Icons.flag, color: Colors.green,),
                            SizedBox(width: 10,),
                            Text('Flag as inappropriate', style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.w500
                            ),)
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
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    'Apply now',
                    onPressed: () { Get.toNamed(AppRoutes.submitproposal);},
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      // padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
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
