import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/jobs_controller.dart';
import '../models/job_model.dart';

void showSelectReasonBottomSheet(BuildContext context, Job job) {
  final theme = Theme.of(context);
  Get.bottomSheet(
    backgroundColor: theme.scaffoldBackgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    isScrollControlled: true,
    Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: SelectReasonBottomSheet(job: job),
    ),
  );
}

class SelectReasonBottomSheet extends StatelessWidget {
  final Job job;
  final JobsController controller = Get.find();

  SelectReasonBottomSheet({required this.job});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Select a Reason",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 20),
                onPressed: () {
                  Get.back(); // Close bottom sheet
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: [
                    "Just not interested",
                    "Vague Description",
                    "Unrealistic Expectations",
                    "Too Many Applicants",
                    "Job posted too long ago",
                    "Poor reviews about the client",
                    "Doesn't Match Skills",
                    "I am overqualified",
                    "Budget too low",
                    "Not in my preferred location"
                  ].length +
                  (controller.selectedReasons.containsKey(job) ? 1 : 0),
              // Add 1 if "Remove Feedback" item is shown
              itemBuilder: (context, index) {
                if (controller.selectedReasons.containsKey(job) && index == 0) {
                  // Show "Remove Feedback" option as the first item
                  return ListTile(
                    dense: true,
                    title: const Text(
                      "Remove Feedback",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    onTap: () {
                      controller.removeFeedback(job);
                      Get.back();
                    },
                  );
                }

                // For all other items
                final reason = [
                  "Just not interested",
                  "Vague Description",
                  "Unrealistic Expectations",
                  "Too Many Applicants",
                  "Job posted too long ago",
                  "Poor reviews about the client",
                  "Doesn't Match Skills",
                  "I am overqualified",
                  "Budget too low",
                  "Not in my preferred location"
                ][index -
                    (controller.selectedReasons.containsKey(job)
                        ? 1
                        : 0)]; // Adjust index if "Remove Feedback" is present

                return ListTile(
                  dense: true,
                  title: Text(
                    reason,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    controller.selectReasons(job, reason);
                    Get.back();
                  },
                );
              },
              separatorBuilder: (context, index) => Divider(
                height: 0,
                thickness: 1,
                color: Colors.grey.withOpacity(0.2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
