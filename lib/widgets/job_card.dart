// import 'package:flutter/material.dart';
// import '../models/job_model.dart';
//
// class JobCard extends StatelessWidget {
//   final Job job;
//
//   const JobCard({Key? key, required this.job}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Title with Like/Dislike Icons
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // Job Title
//                 Expanded(
//                   child: Text(
//                     job.title,
//                     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     overflow: TextOverflow.visible,
//                   ),
//                 ),
//                 // Like and Dislike Buttons
//                 Row(
//                   children: [
//                     Column(
//                       children: [
//                         Icon(Icons.thumb_up, color: Colors.grey[600], size: 20),
//                         // const Text("Like", style: TextStyle(color: Colors.grey, fontSize: 12)),
//                       ],
//                     ),
//                     const SizedBox(width: 16),
//                     Column(
//                       children: [
//                         Icon(Icons.thumb_down, color: Colors.grey[600], size: 20),
//                         // const Text("Dislike", style: TextStyle(color: Colors.grey, fontSize: 12)),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             // Job Description
//             Text(job.description, maxLines: 2, overflow: TextOverflow.ellipsis),
//             const SizedBox(height: 8),
//
//             // Budget and Rating
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Budget: \$${job.budget}", style: TextStyle(color: Colors.green)),
//                 Row(
//                   children: [
//                     const Icon(Icons.star, color: Colors.yellow, size: 16),
//                     Text("${job.rating}"),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//
//             // Tags
//             Wrap(
//               spacing: 8,
//               children: job.tags.map((tag) => Chip(label: Text(tag))).toList(),
//             ),
//             const SizedBox(height: 8),
//
//             // Location (Bottom of Card)
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 const Icon(Icons.location_on, size: 16, color: Colors.grey),
//                 Text(job.location, style: const TextStyle(color: Colors.grey)),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../models/job_model.dart';

class JobCard extends StatefulWidget {
  final Job job;

  const JobCard({Key? key, required this.job}) : super(key: key);

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  bool isHeartSelected = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Posted ${widget.job.postedTimeAgo} ago",
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),

              ],
            ),
            const SizedBox(height: 8),
            // Row: Title and Like/Dislike Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Job Title
                Expanded(

                  child: Text(
                    widget.job.title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.visible,
                  ),
                ),
                // Like and Dislike Buttons
                Row(
                  children: [
                    Column(
                      children: [
                        Icon(Icons.thumb_down, color: Colors.grey[600], size: 20),
                        // const Text("Dislike", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(width: 16),

                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isHeartSelected = !isHeartSelected;
                            });
                          },
                            child: Image.asset(isHeartSelected ? "assets/icon/like.png" : "assets/icon/like2.png",
                              height: 22,
                              width: 22,
                            ))
                      //  Icon(Icons.thumb_up, color: Colors.grey[600], size: 20),
                        // const Text("Like", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Row: "Posted X hours ago" and Payment Verified


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Budget: \$${widget.job.budget}", style: TextStyle(color: Colors.green)),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow, size: 16),
                    Text("${widget.job.rating}"),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Job Description
            Text(
              widget.job.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: widget.job.tags
                          .map((tag) => Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ))
                          .toList(),
                    ),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.verified, color: Colors.green, size: 16),
                const SizedBox(width: 4),
                const Text("Payment Verified", style: TextStyle(color: Colors.green, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                Text(widget.job.location, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}