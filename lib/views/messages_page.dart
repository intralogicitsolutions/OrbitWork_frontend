import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/chat_contoller.dart';
import '../comms/global/string_utils.dart';
import '../comms/utills/date_utils.dart';
import '../component/new_room_bottomsheet.dart';
import '../controllers/chat_list_controller.dart';
import '../controllers/message_controller.dart';
import '../controllers/room_controller.dart';
import '../controllers/user_controller.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_shimmer.dart';

class MessagesPage extends StatefulWidget {
  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final MessageController controller = Get.put(MessageController());

 final ChatListController chatController = Get.put(ChatListController());

  String getInitials(String name) {
    if (name == null || name.trim().isEmpty) {
      return "?"; // Return a default character if name is empty or null
    }
    List<String> nameParts = name.split(' ');
    //return nameParts.take(2).map((part) => part[0].toUpperCase()).join();
    return nameParts
        .where((part) => part.isNotEmpty) // Ensure no empty strings in the list
        .take(2)
        .map((part) => part[0].toUpperCase())
        .join();
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    chatController.fetchChatList(); // Re-fetch when coming back
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
                    child:  NewRoomBottomSheet()),
                isScrollControlled: true,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
              );
              chatController.fetchChatList();
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
                          onChanged: (value) {
                            chatController.searchText.value = value;
                          },
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

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return ListView.builder(
                  itemCount: chatController.chatList.length, // Number of shimmer placeholders
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
               // itemCount: controller.filteredMessages.length,
               // itemCount: userController.users.length,
                itemCount: chatController.filteredChatList.length,
                itemBuilder: (context, index) {
                 // final message = controller.filteredMessages[index];
                  final chatUser = chatController.filteredChatList[index];
                  return GestureDetector(
                    onTap: () {
                      chatUser.isRoom ? Get.toNamed(AppRoutes.groupChat, arguments: {
                        'roomId': chatUser.roomId,
                        'name': chatUser.name
                      })?.then((_) => chatController.fetchChatList())
                          : Get.toNamed(AppRoutes.chat, arguments: {
                        // 'receiverId': user.id,
                        // 'name': "${user.firstname} ${user.lastname}",
                        'receiverId': chatUser.userId,
                        'name': chatUser.name,
                      } )?.then((_) => chatController.fetchChatList());
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
                                            backgroundColor:
                                                Colors.grey.shade400,
                                            child: Text(
                                              StringUtils.getInitials(chatUser.name),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
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
                                        chatUser.name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                            Text(
                                            //  message.title,
                                            //   "${user.email}",
                                              chatUser.messageWithPrefix??'',
                                              style: TextStyle(
                                                  color: Colors.grey.shade500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  // message.date,
                                  DateUtilsHelper.formatDate( "${chatUser.createdAt}"),
                                  //"${user.createdAt}",
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
