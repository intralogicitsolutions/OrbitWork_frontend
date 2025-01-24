import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/job_details_controller.dart';
import '../widgets/custom_button.dart';

class JobDetailsView extends StatelessWidget {
  final JobDetailsController controller = Get.put(JobDetailsController());

  @override
  Widget build(BuildContext context) {
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
                    // Job Title and Details
                    Text(
                      controller.jobDetails.title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                        Text('Send a proposal: ${controller.jobDetails.connects} Connects'),
                        Text('Available Connects: ${controller.jobDetails.availableConnects}'),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Price and Experience Level
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('\$${controller.jobDetails.price.toStringAsFixed(2)}',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(controller.jobDetails.experienceLevel),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(controller.jobDetails.projectType),
                    SizedBox(height: 16),

                    // Skills and Expertise Section
                    Text(
                      'Skills and Expertise',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8.0,
                      children: [
                        Chip(
                          label: Text('React'),
                          backgroundColor: Colors.grey.shade200,
                        ),
                        Chip(
                          label: Text('Clerk'),
                          backgroundColor: Colors.grey.shade200,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Activity on This Job Section
                    Text(
                      'Activity on this job',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Proposals: Less than 5'),
                        Text('Interviewing: 0'),
                        Text('Invites sent: 0'),
                        Text('Unanswered invites: 0'),
                      ],
                    ),
                    SizedBox(height: 16),

                    // About the Client Section
                    Text(
                      'About the client',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                        Text('${controller.jobDetails.hirers} hires, ${controller.jobDetails.activeHirers} active'),
                        Text('\$${controller.jobDetails.avgHourlyRate.toStringAsFixed(2)}/hr avg hourly rate paid'),
                        SizedBox(height: 16),
                        Text(controller.jobDetails.industry),
                        const SizedBox(height: 16),

                        const Text(
                          "Client's recent history (50)",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),

                        // Other open jobs by this Client
                        const Text(
                          "Other open jobs by this Client (7)",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),

                        // Job list
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 5, // Adjust the count dynamically based on your data
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Job title",
                                    style: TextStyle(fontSize: 16, color: Colors.green),
                                  ),
                                ),
                                const Text(
                                  "Fixed-price",
                                  style: TextStyle(fontSize: 14, color: Colors.grey),
                                ),
                                const SizedBox(height: 16),
                              ],
                            );
                          },
                        ),

                        // View more button
                        TextButton(
                          onPressed: () {
                            // Add navigation logic here
                          },
                          child: const Text(
                            "View more (2)",
                            style: TextStyle(fontSize: 16, color: Colors.green),
                          ),
                        ),
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
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: CustomButton(
                    'Save job',
                    onPressed: () {},
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
