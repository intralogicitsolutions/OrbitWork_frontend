import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/room_controller.dart';

import '../comms/global/string_utils.dart';
import '../models/group_members_model.dart';
import '../models/room_model.dart';

class GroupEditPage extends StatelessWidget {
  final String roomId;

  GroupEditPage({required this.roomId});

  final RoomController roomController = Get.put(RoomController());
 // final TextEditingController nameController = TextEditingController();



  // @override
  // Widget build(BuildContext context) {
  //   roomController.getRoomMember(roomId);
  //   return Scaffold(
  //     body: Padding(
  //       padding: const EdgeInsets.all(16),
  //       child: Obx(() {
  //         final roomData = roomController.roomWithMembers.value;
  //         if (roomData == null) {
  //           return Center(child: CircularProgressIndicator());
  //         }
  //         if (!roomController.isEditingName.value)
  //           nameController.text = roomData.roomName;
  //         return ListView(
  //           children: [
  //             // Group Profile Image
  //             Center(
  //               child: CircleAvatar(
  //                 radius: 40,
  //                 backgroundColor: Colors.grey.shade400,
  //                 child: Text(
  //                   StringUtils.getInitials(roomData.roomName),
  //                   style: TextStyle(
  //                       fontSize: 20,
  //                       fontWeight: FontWeight.bold,
  //                       color: Colors.white),
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(height: 16),
  //
  //             Stack(
  //               alignment: Alignment.center,
  //               children: [
  //                 roomController.isEditingName.value
  //                     ? Padding(
  //                   padding: const EdgeInsets.only(right: 40), // reserve space for the icon
  //                   child: TextField(
  //                     controller: nameController,
  //                    // textAlign: TextAlign.center,
  //                     decoration: InputDecoration(
  //                       labelText: "Group Name",
  //                       border: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(12),
  //                       ),
  //                     ),
  //                   ),
  //                 )
  //                     : Text(
  //                   roomData.roomName,
  //                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //                   textAlign: TextAlign.center,
  //                 ),
  //
  //                 // Positioned Icon Button on the right
  //                 Positioned(
  //                   right: 0,
  //                   child: IconButton(
  //                     icon: Icon(
  //                       roomController.isEditingName.value ? Icons.check : Icons.edit,
  //                       size: 20,
  //                       color: Colors.green,
  //                     ),
  //                     onPressed: () {
  //                       if (roomController.isEditingName.value) {
  //                         roomController.updateRoom(
  //                           roomId: roomId,
  //                           name: nameController.text.trim(),
  //                         );
  //                       }
  //                       roomController.isEditingName.toggle();
  //                     },
  //                   ),
  //                 ),
  //               ],
  //             ),
  //
  //             const SizedBox(height: 8),
  //
  //             // Group Info
  //             Text(
  //               "Group · ${roomData.members.length} members",
  //               style: TextStyle(color: Colors.grey[600]),
  //               textAlign: TextAlign.center,
  //             ),
  //             const SizedBox(height: 16),
  //
  //             Text("Group Members",
  //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
  //             const SizedBox(height: 8),
  //             if (roomData.members
  //                 .firstWhere((m) => m.id == roomData.currentUserId)
  //                 .isAdmin)
  //               ListTile(
  //                 title: Text(
  //                   'Add Members',
  //                   style: TextStyle(fontWeight: FontWeight.bold),
  //                 ),
  //                 leading: CircleAvatar(
  //                     backgroundColor: Colors.green,
  //                     child: Icon(
  //                       Icons.person_add_alt,
  //                       color: Colors.white,
  //                     )),
  //                 onTap: () {
  //                   _showAddMemberBottomSheet(context);
  //                 },
  //               ),
  //
  //             ...roomData.members.map((member) {
  //               return ListTile(
  //                   onTap: () {
  //                     final isCurrentUserAdmin = roomData.members
  //                         .firstWhere((m) => m.id == roomData.currentUserId)
  //                         .isAdmin;
  //
  //                     if (isCurrentUserAdmin &&
  //                         member.id != roomData.currentUserId) {
  //                       _showMemberOptions(context, member);
  //                     }
  //                   },
  //                   leading: CircleAvatar(
  //                     backgroundColor: Colors.grey.shade400,
  //                     child: Text(
  //                       StringUtils.getInitials(
  //                           "${member.firstname} ${member.lastname}"),
  //                       style: TextStyle(
  //                           fontWeight: FontWeight.bold, color: Colors.white),
  //                     ),
  //                   ),
  //                   title: Text( member.id == roomData.currentUserId ? "You" :"${member.firstname} ${member.lastname}"),
  //                   subtitle: Text(member.email),
  //                   trailing: member.isAdmin
  //                       ? Text(
  //                           'Group Admin',
  //                           style: TextStyle(color: Colors.green),
  //                         )
  //                       : null);
  //             }).toList(),
  //             SizedBox(
  //               height: 10,
  //             ),
  //             ListTile(
  //               title: Text(
  //                 'Exit Group',
  //                 style:
  //                     TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
  //               ),
  //               leading: Icon(Icons.exit_to_app, color: Colors.red),
  //               onTap: () {
  //                 final currentUser = roomData.members
  //                     .firstWhere((m) => m.id == roomData.currentUserId);
  //                 final adminCount =
  //                     roomData.members.where((m) => m.isAdmin).length;
  //
  //                 if (currentUser.isAdmin && adminCount == 1) {
  //                   // Show warning dialog
  //                   _showMakeAdminFirstDialog(context);
  //                 } else {
  //                   _showExitGroupDialog(context, roomData.currentUserId ?? '');
  //                 }
  //               },
  //             ),
  //           ],
  //         );
  //       }),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    roomController.getRoomMember(roomId);
    final nameController = roomController.nameController;
    return Obx(() {
      final roomData = roomController.roomWithMembers.value;
      final isEditing = roomController.isEditingName.value;

      if (roomData == null) {
        return Scaffold(
         // appBar: AppBar(title: Text("Group")),
          body: Center(child: CircularProgressIndicator()),
        );
      }

      if (!isEditing && nameController?.text != roomData.roomName) {
        roomController.suppressListener = true;
        nameController?.text = roomData.roomName;
        roomController.originalGroupName.value = roomData.roomName;
        Future.delayed(Duration.zero, () {
          roomController.suppressListener = false; // re-enable listener
        });
      }

      // final nameChanged =
      //     nameController?.text.trim() != roomController.originalGroupName.value.trim();

     final nameChanged = roomController.hasNameChanged.value;
      print('isEditing : ${isEditing}');
      print('nameChanged : ${nameChanged}');
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: isEditing
              ? TextButton(
            onPressed: () {
              // Cancel editing
              roomController.suppressListener = true;
              roomController.isEditingName.value = false;
              nameController?.text = roomController.originalGroupName.value;
              Future.delayed(Duration.zero, () {
                roomController.suppressListener = false;
              });
            },
            child: Text("Cancel", style: TextStyle(color: Get.theme.secondaryHeaderColor)),
          )
              : null,
          actions: [
            TextButton(
              onPressed: isEditing
                  ? (nameChanged
                  ? () {
                roomController.updateRoom(
                  roomId: roomId,
                  name: nameController?.text.trim(),
                );
                roomController.isEditingName.value = false;
              }
                  : null)
                  : () {
                roomController.isEditingName.value = true;
              },
              child: Text(
                isEditing ? "Done" : "Edit",
                style: TextStyle(
                  color: isEditing
                      ? (nameChanged ? Get.theme.secondaryHeaderColor : Colors.grey[400])
                      : Get.theme.secondaryHeaderColor,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
          child: ListView(
            children: [
              // Group Profile Image
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey.shade400,
                  child: Text(
                    StringUtils.getInitials(roomData.roomName),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Group Name (TextField or Text)
              Center(
                child: isEditing
                    ? TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Group Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  textAlign: TextAlign.center,
                )
                    : Text(
                  roomData.roomName,
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 8),
              Text(
                "Group · ${roomData.members.length} members",
                style: TextStyle(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              Text("Group Members",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),

              // Add Members (Only if current user is admin)
              if (roomData.members
                  .firstWhere((m) => m.id == roomData.currentUserId)
                  .isAdmin)
                ListTile(
                  title: Text(
                    'Add Members',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Icon(Icons.person_add_alt, color: Colors.white)),
                  onTap: () {
                    _showAddMemberBottomSheet(context);
                  },
                ),

              // Member List
              ...roomData.members.map((member) {
                final isCurrentUserAdmin = roomData.members
                    .firstWhere((m) => m.id == roomData.currentUserId)
                    .isAdmin;

                return Card(
                  elevation: 1,
                  color: Get.theme.scaffoldBackgroundColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    onTap: () {
                      if (isCurrentUserAdmin &&
                          member.id != roomData.currentUserId) {
                        _showMemberOptions(context, member);
                      }
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.shade400,
                      child: Text(
                        StringUtils.getInitials(
                            "${member.firstname} ${member.lastname}"),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    title: Text(member.id == roomData.currentUserId
                        ? "You"
                        : "${member.firstname} ${member.lastname}"),
                    subtitle: Text(member.email),
                    trailing: member.isAdmin
                        ? Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        'Admin',
                        style: TextStyle(color: Colors.green),
                      ),
                    )
                        : null,
                  ),
                );
              }).toList(),

              const SizedBox(height: 10),
              ListTile(
                title: Text(
                  'Exit Group',
                  style:
                  TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                leading: Icon(Icons.exit_to_app, color: Colors.red),
                onTap: () {
                  final currentUser = roomData.members
                      .firstWhere((m) => m.id == roomData.currentUserId);
                  final adminCount =
                      roomData.members.where((m) => m.isAdmin).length;

                  if (currentUser.isAdmin && adminCount == 1) {
                    _showMakeAdminFirstDialog(context);
                  } else {
                    _showExitGroupDialog(context, roomData.currentUserId ?? '');
                  }
                },
              ),
            ],
          ),
        ),
      );
    });
  }


  void _showMemberOptions(BuildContext context, Member member) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  member.isAdmin
                      ? Icons.person_remove
                      : Icons.admin_panel_settings,
                  color: Colors.black,
                ),
                title: Text(
                  member.isAdmin ? 'Dismiss as Admin' : 'Make Group Admin',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  if (member.isAdmin) {
                    await roomController.removeGroupAdmin(roomId, member.id);
                  } else {
                    await roomController.makeGroupAdmin(roomId, member.id);
                  }
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.person_remove,
                  color: Colors.black,
                ),
                title: Text(
                  'Remove ${member.firstname}',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                onTap: () async {
                  _showRemoveDialog(member.id, member.firstname, context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showExitGroupDialog(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Leave Group'),
        content: Text('Are you sure you want to leave this group?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              roomController.leaveRoom(roomId, userId); // Call socket method
              Get.back(); // Optionally pop back to previous screen
            },
            child: Text('Yes', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showMakeAdminFirstDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cannot Leave Group'),
        content: Text(
            'You are the only Group Admin. Please assign another member as admin before leaving.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showAddMemberBottomSheet(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Enter email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  roomController.updateRoom(
                    roomId: roomId,
                    //  roomId,
                    addMembers: [emailController.text.trim()],
                  );
                  Get.back();
                },
                child: Text("Add Member"),
              )
            ],
          ),
        );
      },
    );
  }

  void _showRemoveDialog(String memberId, String name, BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Remove Member"),
        content: Text("Are you sure you want to remove $name?"),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              roomController.updateRoom(
                roomId: roomId,
                // widget.roomId,
                removeMembers: [memberId],
              );
              Get.back();
            },
            child: Text("Remove"),
          ),
        ],
      ),
    );
  }
}
