import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../component/select_reason_bottom_sheet.dart';
import '../controllers/jobs_controller.dart';
import '../models/job_model.dart';
import 'custom_shimmer.dart';
import 'package:get_time_ago/get_time_ago.dart';

class JobCard extends StatelessWidget {
  final Job job;
  final JobsController controller = Get.find();

  JobCard({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(() {
      bool isExpanded = controller.expandedJobs[job] ?? false;
     // bool isExpanded = controller.expandedJob.value == job;
      bool hasFeedback = controller.selectedReasons.containsKey(job);

      return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
       //margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
        child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () {
                      if (controller.isLoading.value) {
                      return CustomShimmer(width: MediaQuery.of(context).size.width *0.3, height: 10,);
                    }
                      DateTime createdAt = job.createdAt;
                      String timeAgo = GetTimeAgo.parse(createdAt, locale: 'en');
                      return Text(
                        "Posted $timeAgo",
                        style: TextStyle(
                          //color: Theme.of(context).textTheme.bodySmall?.color,
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                        //style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      );
                    }
                  ),
                ],
              ),
              // const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                     () {
                       if (controller.isLoading.value) {
                         return CustomShimmer(width: MediaQuery.of(context).size.width *0.5, height: 20,);
                       }//for skeleton
                      return Expanded(
                        child: Text(
                          job.title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                          // style: const TextStyle(
                          //     fontSize: 16, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.visible,
                        ),
                      );
                    }
                  ),
                  // Display TextButton ("Expand"/"Collapse") when hasFeedback is true
                  hasFeedback
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (isExpanded) ...[
                              Row(
                                children: [
                                  // Show these icons when hasFeedback is false
                                  IconButton(
                                    icon: Icon(
                                      Icons.thumb_down_alt_outlined,
                                      //color: Colors.black,
                                      color: theme.iconTheme.color,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      showSelectReasonBottomSheet(context, job);
                                    },
                                  ),
                                  Obx(
                                    () {
                                      return IconButton(
                                        icon: Icon(
                                          controller.favoriteJobs.contains(job)
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          //color: Colors.black,
                                          color: Theme.of(context).iconTheme.color,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          controller.toggleFavorite(job);
                                        },
                                      );
                                    }
                                  ),
                                ],
                              ),
                            ],
                            // Show Expand/Collapse button if isExpanded is true
                            TextButton(
                              onPressed: () {
                                print('isExpanded2 ===> ${isExpanded}');
                                controller.toggleExpand(job);
                              },
                              child: Text(
                                isExpanded ? "Collapse" : "Expand",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            // Show the icons (thumb_down_alt_outlined, favorite) when isExpanded is true
                          ],
                        )
                      : Row(
                          children: [
                            // Show these icons when hasFeedback is false
                            IconButton(
                              icon: Icon(
                                Icons.thumb_down_alt_outlined,
                                color: theme.iconTheme.color,
                                // color: Colors.black,
                                size: 20,
                              ),
                              onPressed: () {
                                showSelectReasonBottomSheet(context, job);
                              },
                            ),
                            Obx(
                              () {
                                return IconButton(
                                  icon: Icon(
                                    controller.favoriteJobs.contains(job)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: theme.iconTheme.color,
                                    // color: Colors.black,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    controller.toggleFavorite(job);
                                  },
                                );
                              }
                            ),
                          ],
                        ),
                ],
              ),
              if (hasFeedback && !isExpanded) ...[
                const SizedBox(height: 8),
                Text(
                  "${controller.selectedReasons[job]}",
                  // Display the selected reason
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    //color: Colors.black87
                  ),
                ),
              ],
              const SizedBox(height: 8),
              if (isExpanded || !hasFeedback) ...[
                // const SizedBox(height: 8),
                Obx(
                   () {
                     if (controller.isLoading.value) {
                       return CustomShimmer(width: MediaQuery.of(context).size.width *0.7, height: 12,);
                     }
                    return job.isFixedPrice
                        ? Text(
                            "Fixed Price - Intermediate - Est. Budget: \$${job.budget}",
                            style: TextStyle(
                                fontSize: 12,
                                //color: Theme.of(context).textTheme.bodySmall?.color
                                color: Colors.grey.shade600),
                          )
                        : Text(
                            "Hourly: \$${job.hourlyRateMin ?? 0.0} - \$${job.hourlyRateMax ?? 0.0} - Intermediate - Est. Time: ${job.estimatedTime ?? ''}, ${job.hoursPerWeek ?? 0} hrs/week",
                            style: TextStyle(
                                fontSize: 12,
                                //color: Theme.of(context).textTheme.bodySmall?.color,
                                color: Colors.grey.shade600),
                          );
                  }
                ),
                const SizedBox(height: 8),
                Obx(
                   () {
                     if (controller.isLoading.value) {
                       return CustomShimmer(width: MediaQuery.of(context).size.width *0.7, height: 20,);
                     }
                    return Text(
                      job.jobDescription??'',
                      style: Theme.of(context).textTheme.bodyMedium,
                      // style: const TextStyle(fontSize: 14, color: Colors.black87),
                    );
                  }
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                         () {
                           if (controller.isLoading.value) {
                             return CustomShimmer(width: MediaQuery.of(context).size.width *0.7, height: 20,);
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
                    ),
                    const Icon(Icons.arrow_forward_ios,
                        size: 16, color: Colors.grey),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.verified,
                            color: Colors.green, size: 16),
                        const SizedBox(width: 4),
                        Text("Payment Verified",
                            style: TextStyle(
                                color: theme.primaryColor,
                                // color: Colors.green,
                                fontSize: 12)),
                      ],
                    ),
                    Obx(
                       () {if (controller.isLoading.value) {
                         return CustomShimmer(width: MediaQuery.of(context).size.width *0.1, height: 16,);
                       }
                        return Row(
                          children: [
                            Icon(Icons.star,
                                color: Colors.yellow.shade700, size: 16),
                            Text("${job.rating}"),
                          ],
                        );
                      }
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.grey
                        // color: theme.iconTheme.color
                        ),
                    // color: Colors.grey

                    Obx(
                       () {
                         if (controller.isLoading.value) {
                           return CustomShimmer(width: MediaQuery.of(context).size.width *0.2, height: 12,);
                         }
                        return Text(job.location,
                            style: TextStyle(
                                fontSize: 12,
                                // color: theme.textTheme.bodySmall?.color,
                                color: Colors.grey));
                      }
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Obx(
                   () {if (controller.isLoading.value) {
                     return CustomShimmer(width: MediaQuery.of(context).size.width *0.7, height: 20,);
                   }
                    return Row(
                      children: [
                        Text("Proposals : 10 to 15"),
                      ],
                    );
                  }
                ),
              ],
              const SizedBox(height: 8),
              Divider()
            ],
          ),
        ),
      );
    });
  }
}
