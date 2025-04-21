import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:orbitwork/repository/api/api_constants.dart';
import '../global/tokenStorage.dart';
import '../models/group_members_model.dart';
import '../models/room_model.dart';
import 'package:http/http.dart' as http;

import '../routes/app_routes.dart';
import '../socket/socket_service/socket_service.dart';
import 'chat_list_controller.dart';

class RoomController extends GetxController {
  var people = <String>[].obs;
  var roomName = ''.obs;
  var room = <Room>[].obs;
  var roomWithMembers = Rxn<RoomWithMembers>();
  final String? roomId;
  var isEditingName = false.obs;
  final RxString originalGroupName = ''.obs;
  final RxBool hasNameChanged = false.obs;
   TextEditingController? nameController;
  bool suppressListener = false;
  final ChatListController chatController = Get.put(ChatListController());

  RoomController({this.roomId});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final socketService = Get.find<SocketService>();
    socketService.listenForLeftRoom((data) {
      print('Left room: ${data['message']}');
      // Optional: show a toast or navigate away
    });
    nameController = TextEditingController();
    nameController?.addListener(() {
      if (suppressListener) return;
      final trimmedText = nameController?.text.trim();
      hasNameChanged.value = trimmedText != originalGroupName.value.trim();
    });
    //getRoomMember(roomId??'');
  }

  @override
  void onClose() {
    nameController?.dispose();
    super.onClose();
  }


  void addPerson(String email) {
    if (!_isValidEmail(email)) {
      Get.snackbar("Invalid email", "Please enter a valid email address");
      return;
    }
    if (!people.contains(email)) {
      people.add(email);
    }
  }

  void removePerson(String email) {
    people.remove(email);
  }

  void setRoomName(String name) {
    roomName.value = name.trim();
  }

  void leaveRoom(String roomId, String userId) {
    final socketService = Get.find<SocketService>();
    socketService.leaveRoom(roomId, userId);
  }



  bool _isValidEmail(String email) {
    final emailRegExp = RegExp(r"^[\w\.-]+@[\w\.-]+\.\w{2,4}$");
    return emailRegExp.hasMatch(email);
  }

  Future<void> createRoom() async {
    String? token = await TokenStorage.getToken();
    if (people.isEmpty) {
      Get.snackbar("Empty list", "Please add at least one person");
      return;
    }

    if (roomName.isEmpty) {
      Get.snackbar("Missing name", "Please enter a room name");
      return;
    }

    final url = Uri.parse(ApiConstants.CREATE_ROOM);

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': '$token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': roomName.value,
          'members': people, // assuming backend accepts email list
        }),
      );
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      final data = jsonDecode(response.body);

      if (data['success'] == 1) {
        String roomId = data['body']['_id'];
        String roomname = data['body']['name'];

       // chatController.fetchChatList();
        Get.back(); // Close bottom sheet
        Get.snackbar(
            "Room Created", "Room '${roomName.value}' created successfully");
        Get.toNamed(AppRoutes.groupChat, arguments: {
          'roomId': roomId,
          'name': roomname
        })?..then((_) => chatController.fetchChatList());
        people.clear();
        roomName.value = '';
      } else {
        Get.snackbar("Error", data['msg'] ?? "Failed to create room");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }

  Future<void> getRoomMember(String roomId) async{
    String? token = await TokenStorage.getToken();
    final url = Uri.parse('${ApiConstants.GET_ROOM_MEMBERS}/$roomId');
    try{
      print('get room members url ==> ${url}');
    final response = await http.get(
      url,
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
    );

    if(response.statusCode == 200){
      var jsonData = json.decode(response.body);
      roomWithMembers.value = RoomWithMembers.fromJson(jsonData['body']);
      // if (jsonData['body'] is List) {
      //   room.value = (jsonData['body'] as List)
      //       .map((msg) => Room.fromJson(msg))
      //       .toList();
      // } else {
      //   List<dynamic> messageList = jsonData['body'];
      //   room.value =
      //       messageList.map((msg) => Room.fromJson(msg)).toList();
      // }
    } else {
      print("Failed to load room members: ${response.body}");
    }
    } catch (e) {
      print("Error fetching messages: $e");
    }
  }

  Future<void> updateRoom({
    required String roomId,
     String? name,
     List<String>? addMembers,
     List<String>? removeMembers,
  }) async {
    String? token = await TokenStorage.getToken();

    final url = Uri.parse("${ApiConstants.UPDATE_ROOM}/$roomId");
    // final body = jsonEncode({
    //   "name": name,
    //   "addMembers": addMembers,
    //   "removeMembers": removeMembers,
    // });
    final Map<String, dynamic> requestData = {};
    if (name != null) requestData['name'] = name;
    if (addMembers != null) requestData['addMembers'] = addMembers;
    if (removeMembers != null) requestData['removeMembers'] = removeMembers;

    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': '$token',
          'Content-Type': 'application/json',
        },
        //body: body,
        body: jsonEncode(requestData),
      );

      if (response.body.isEmpty) {
        throw Exception("Empty response body from server");
      }

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Get.snackbar("Success", data['msg']);
        print("Updated Room Data: ${data['body']}");
        await getRoomMember(roomId);
      } else {
        Get.snackbar("Error", data['msg'] ?? "Update failed");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
      print("Exception: $e");
    }
  }

  // Create Admin
  Future<void> makeGroupAdmin(String roomId, String memberId) async {
    String? token = await TokenStorage.getToken();
    final response = await http.post(
      Uri.parse(ApiConstants.CREATE_ADMIN),
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "room_id": roomId,
        "admin_member": memberId,
      }),
    );
    final data = jsonDecode(response.body);
    if (data['success'] == 1) {
      //Get.snackbar("Success", data['msg']);
      await getRoomMember(roomId); // refresh members
    } else {
      Get.snackbar("Error", data['msg']);
    }
  }

  // Remove Admin
  Future<void> removeGroupAdmin(String roomId, String memberId) async {
    String? token = await TokenStorage.getToken();
    final response = await http.put(
      Uri.parse(ApiConstants.REMOVE_ADMIN),
      headers: {
        'Authorization': '$token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "room_id": roomId,
        "admin_member": memberId,
      }),
    );
    final data = jsonDecode(response.body);
    if (data['success'] == 1) {
      // Get.snackbar("Success", data['msg']);
      await getRoomMember(roomId); // refresh members
    } else {
      Get.snackbar("Error", data['msg']);
    }
  }
}
