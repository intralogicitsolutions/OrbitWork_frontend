// import 'package:flutter/material.dart';
//
// import '../widgets/custom_appbar.dart';
//
// class MessagesPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: "Message",
//         rightIcon: Container(
//           width: 40,
//           height: 40,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             border: Border.all(
//               color: theme.dividerColor,
//               // color: Colors.black,
//               width: 1,
//             ),
//           ),
//           child: IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               print("Notifications clicked");
//             },
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Wrap(
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 12.0),
//                       child: TextField(
//                         decoration: InputDecoration(
//                           hintText: "Search for jobs",
//                           prefixIcon: const Icon(Icons.search),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         onChanged: (value) {},
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: IconButton(
//                       icon: Icon(Icons.filter,
//                         color: Colors.green,
//                       ),
//                       onPressed: () {},
//                     ),
//                   ),
//
//                 ],
//               ),
//             ],
//           ),
//           ListView(
//             children: [
//               Row(
//                 children: [
//
//                 ],
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/message_controller.dart';
import '../widgets/custom_appbar.dart';

class MessagesPage extends StatelessWidget {
  final MessageController controller = Get.put(MessageController());

  String getInitials(String name) {
    List<String> nameParts = name.split(' ');
    return nameParts.take(2).map((part) => part[0].toUpperCase()).join();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: "Message",
        rightIcon: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: theme.dividerColor,
              // color: Colors.black,
              width: 1,
            ),
          ),
          child: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              print("Notifications clicked");
            },
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Wrap(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search",
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.filter_list,
                        color: Colors.green,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Message List
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.filteredMessages.length,
                itemBuilder: (context, index) {
                  final message = controller.filteredMessages[index];

                  return Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 5), // Optional spacing
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // Align title and trailing
                          children: [
                            Row(
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  // Ensures the dot can overflow outside the stack
                                  children: [
                                    CircleAvatar(
                                      child: Text(
                                        getInitials(message.name),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      backgroundColor: Colors.grey.shade400,
                                    ),
                                    Positioned(
                                      top: 1,
                                      // Position the dot slightly above the CircleAvatar
                                      left: 1,
                                      // Position the dot slightly to the left of the CircleAvatar
                                      child: Container(
                                        width: 9, // Size of the dot
                                        height: 9,
                                        decoration: BoxDecoration(
                                          color: theme.scaffoldBackgroundColor, // Dot color
                                          shape: BoxShape
                                              .circle, // Makes the container circular
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 2,
                                      // Position the dot slightly above the CircleAvatar
                                      left: 2,
                                      // Position the dot slightly to the left of the CircleAvatar
                                      child: Container(
                                        width: 6, // Size of the dot
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: theme.unselectedWidgetColor, // Dot color
                                          shape: BoxShape
                                              .circle, // Makes the container circular
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                // Space between avatar and title
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      message.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      message.title,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(
                                      message.lastMessage,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              message.date,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),

                      Divider()
                    ],
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
