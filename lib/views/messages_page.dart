import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import '../component/new_room_bottomsheet.dart';
import '../controllers/message_controller.dart';
import '../controllers/room_controller.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_shimmer.dart';

class MessagesPage extends StatelessWidget {
  final MessageController controller = Get.put(MessageController());

  String getInitials(String name) {
    List<String> nameParts = name.split(' ');
    return nameParts.take(2).map((part) => part[0].toUpperCase()).join();
  }

  void showNewRoomSheet() {
    Get.lazyPut(() => RoomController());

    Get.bottomSheet(
      const NewRoomBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    ).then((_) {
      Get.delete<RoomController>();
    });
  }


  void _showPopupMenu(BuildContext context, TapDownDetails details) async {
    final selectedValue = await showMenu<int>(
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx + 1,
        details.globalPosition.dy + 1,
      ),
      color: Get.theme.scaffoldBackgroundColor,
      items: [
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              Icon(Icons.mail_outline),
              SizedBox(width: 8),
              Text("Unread"),
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              Icon(Icons.star_border),
              SizedBox(width: 8),
              Text("Favorite"),
            ],
          ),
        ),
        // Contract Header (Toggleable)
        PopupMenuItem(
          enabled: false,
          child: GestureDetector(
            onTap: () {
              controller.toggleContract();
              Navigator.pop(context); // Close menu
              Future.delayed(Duration(milliseconds: 200), () {
                _showPopupMenu(context, details); // Reopen with updated state
              });
            },
            child: Row(
              children: [
                Icon(Icons.article_outlined, color: Get.theme.secondaryHeaderColor,),
                SizedBox(width: 8),
                Text("Contract", style: TextStyle(color: Get.theme.secondaryHeaderColor)),
                Spacer(),
                Obx(() => Icon(
                    controller.isContractExpanded.value
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down)),
              ],
            ),
          ),
        ),
        if (controller.isContractExpanded.value) ...[
          PopupMenuItem(
            value: 3,
            child: Row(
              children: [
                SizedBox(width: 24),
                Icon(Icons.send),
                SizedBox(width: 8),
                Text("All Contracts"),
              ],
            ),
          ),
          PopupMenuItem(
            value: 4,
            child: Row(
              children: [
                SizedBox(width: 24),
                Icon(Icons.label_sharp),
                SizedBox(width: 8),
                Text("Fixed-Price Contracts"),
              ],
            ),
          ),
          PopupMenuItem(
            value: 7,
            child: Row(
              children: [
                SizedBox(width: 24),
                Icon(Icons.access_time),
                SizedBox(width: 8),
                Text("Hourly Contracts"),
              ],
            ),
          ),
        ],
        PopupMenuItem(
                  enabled: false,
                  child: GestureDetector(
                    onTap: () {
                      controller.toggleOther();
                      Navigator.pop(context); // Close menu
                      Future.delayed(Duration(milliseconds: 200), () {
                        _showPopupMenu(context, details); // Reopen with updated state
                      });
                    },
                    child: Row(
                      children: [
                        Icon(Icons.chat_bubble_outline, color: Get.theme.secondaryHeaderColor,),
                        SizedBox(width: 8),
                        Text("Other",
                            style: TextStyle(color: Get.theme.secondaryHeaderColor)),
                        Spacer(),
                        Obx(() => Icon(
                            controller.isOtherExpanded.value
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down)),
                      ],
                    ),
                  ),
                ),
                // Other Submenu (Only shown when expanded)
                if (controller.isOtherExpanded.value) ...[
                  PopupMenuItem(
                    value: 5,
                    child: Row(
                      children: [
                        SizedBox(width: 24),
                        Icon(Icons.person_search),
                        SizedBox(width: 8),
                        Text("Interviews"),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 6,
                    child: Row(
                      children: [
                        SizedBox(width: 24),
                        Icon(Icons.visibility_off,),
                        SizedBox(width: 8),
                        Text("Hidden & Archived"),
                      ],
                    ),
                  ),
                ],
      ],
    );

    if (selectedValue != null) {
      controller.setSelectedFilter(selectedValue);
    }
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
            icon: Icon(
              Icons.add,
              size: 20,
            ),
            onPressed: () {
              Get.bottomSheet(
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: const NewRoomBottomSheet()),
                isScrollControlled: true,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
              );
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
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search",
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 12),
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTapDown: (TapDownDetails details) => _showPopupMenu(context, details),
                      child: Icon(Icons.filter_list, color: Colors.green),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Obx(() => controller.isFilterMenuVisible.value
          //     ? _buildFilterMenu()
          //     : const SizedBox.shrink()),
          // Message List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return ListView.builder(
                  itemCount: 2, // Number of shimmer placeholders
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: CustomShimmer(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 40,
                      ),
                    );
                  },
                );
              }
              return ListView.builder(
                itemCount: controller.filteredMessages.length,
                itemBuilder: (context, index) {
                  final message = controller.filteredMessages[index];
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.chat, arguments: message.name);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          // if (controller.isLoading.value) {
                          //   return CustomShimmer(width: MediaQuery.of(context).size.width * 0.9 , height: 40,);
                          // }
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            // Optional spacing
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // Align title and trailing
                              children: [
                                Expanded(
                                  child: Row(
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
                                            backgroundColor:
                                                Colors.grey.shade400,
                                          ),
                                          Positioned(
                                            top: 1,
                                            left: 1,
                                            child: Container(
                                              width: 9, // Size of the dot
                                              height: 9,
                                              decoration: BoxDecoration(
                                                color: theme
                                                    .scaffoldBackgroundColor,
                                                // Dot color
                                                shape: BoxShape
                                                    .circle, // Makes the container circular
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 2,
                                            left: 2,
                                            child: Container(
                                              width: 6, // Size of the dot
                                              height: 6,
                                              decoration: BoxDecoration(
                                                color:
                                                    theme.unselectedWidgetColor,
                                                // Dot color
                                                shape: BoxShape
                                                    .circle, // Makes the container circular
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              message.name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                            Text(
                                              message.title,
                                              style: TextStyle(
                                                  color: Colors.grey.shade500),
                                            ),
                                            Text(
                                              message.lastMessage,
                                              style: TextStyle(
                                                  color: theme.hintColor,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  message.date,
                                  style: TextStyle(
                                      color: theme.dividerColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          Divider()
                        ],
                      ),
                    ),
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
