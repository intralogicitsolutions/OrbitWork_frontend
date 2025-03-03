import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class TimelineWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey[300]!),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Timeline visualization
//           SizedBox(
//             height: 70,
//             child: LayoutBuilder(
//               builder: (context, constraints) {
//                 double totalWidth = constraints.maxWidth; // Get total width
//                 double segmentWidth = totalWidth / 3; // Divide into 3 equal parts
//
//                 return Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     // Horizontal line
//                     Positioned(
//                       left: 0,
//                      right: 0,
//                       top: 37,
//                       child: Container(
//                         height: 2,
//                         color: Colors.grey[800],
//                       ),
//                     ),
//
//                     // Timeline points (Start, 90, 180, 270 days)
//                     for (int i = 0; i < 4; i++)
//                       Positioned(
//                         left: i == 3 ? null : i * segmentWidth,
//                         right: i == 3 ? 0 : null,
//                         top: 33,
//                         child: Container(
//                           width: 8,
//                           height: 8,
//                           decoration: BoxDecoration(
//                             color: Colors.black,
//                             shape: BoxShape.circle,
//                           ),
//                         ),
//                       ),
//
//                     // Dollar markers
//                     for (int i = 1; i < 4; i++)
//                       Positioned(
//                         left: i == 3 ? null : (i - 0.6) * segmentWidth,
//                         right: i == 3 ? 30 : null,
//                         top: 0,
//                         child: Image.asset(
//                           'assets/icon/placeholder.png',
//                           height: 24,
//                           width: 24,
//                         ),
//                       ),
//
//                     // Labels
//                     Positioned(
//                       left: 0,
//                       bottom: 0,
//                       child: Text(
//                         'Start',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey[700],
//                         ),
//                       ),
//                     ),
//                     for (int i = 1; i < 4; i++)
//                       Positioned(
//                         left: i == 3 ? null : i * segmentWidth - 20,
//                         right: i == 3 ? 0 : null,
//                         bottom: 0,
//                         child: Text(
//                           '${i * 90} days',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey[700],
//                           ),
//                         ),
//                       ),
//                   ],
//                 );
//               },
//             ),
//           ),
//
//           SizedBox(height: 30),
//
//           // Example text
//           Text(
//             'For example, this contract would be considered 3 "jobs".',
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.grey[700],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



class TimelineWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  3,
                  (index) => Image.asset(
                          'assets/icon/placeholder.png',
                          height: 24,
                          width: 24,
                        ),// Dollar icons
                ),
              ),

              SizedBox(height: 5),
              SizedBox(
                width: double.infinity,
                height: 20,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) {
                      return Row(
                        children: [
                          // Step Dot
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Get.theme.secondaryHeaderColor,
                              shape: BoxShape.circle,
                            ),
                          ),

                          // Step Connector Line (only if it's not the last dot)
                          if (index != 3)
                            SizedBox(width: 70, child: Divider(color: Get.theme.secondaryHeaderColor, thickness: 2)),
                            // Container(
                            //   height: 2, // Thickness of the line
                            //   color: Colors.grey,
                            // ),
                        ],
                      );
                    }),
                  ),
                ),
              ),

              SizedBox(height: 10),

              // Labels
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Start',
                        style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                    Text('90 days',
                        style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                    Text('180 days',
                        style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                    Text('270 days',
                        style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                  ],
                ),
              ),

              SizedBox(height: 10),
            ],
          ),

          SizedBox(height: 30),

          // Example text
          Text(
            'For example, this contract would be considered 3 "jobs".',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}



class Timeline extends StatelessWidget {
  final int dollarCount; // Number of dollar icons
  final int stepCount; // Number of steps (dots)
  final List<String> labels; // Labels for each step
  final List<Color> lineColors; // Custom colors for lines between dots
  final Color dotColor; // Color of the dots

  const Timeline({
    Key? key,
    this.dollarCount = 3,
    this.stepCount = 4,
    required this.labels,
    required this.lineColors, // Expecting a list of colors for lines
    this.dotColor = Colors.grey, // Default color for dots
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Dollar Icon Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            dollarCount,
                (index) => Image.asset(
              'assets/icon/placeholder.png',
              height: 24,
              width: 24,
            ),
          ),
        ),

        SizedBox(height: 5),

        // Steps (Dots & Lines)
        SizedBox(
          width: double.infinity,
          height: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(stepCount, (index) {
                return Row(
                  children: [
                    // Step Dot
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: dotColor,
                        shape: BoxShape.circle,
                      ),
                    ),

                    // Step Connector Line (Only if not the last dot)
                    if (index != stepCount - 1)
                      SizedBox(
                        width: 45,
                        child: Divider(
                          color: lineColors.length > index ? lineColors[index] : Colors.grey, // Assign different line color dynamically
                          thickness: 2,
                        ),
                      ),
                  ],
                );
              }),
            ),
          ),
        ),

        SizedBox(height: 10),

        // Labels
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            children: labels
                .map((label) => Expanded(
                child: Text(
                  label,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                )))
                .toList(),
          ),
        ),

        SizedBox(height: 10),
      ],
    );
  }
}

