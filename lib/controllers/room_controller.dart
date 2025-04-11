import 'dart:convert';

import 'package:get/get.dart';
import 'package:orbitwork/repository/api/api_constants.dart';
import '../global/tokenStorage.dart';
import '../models/room_model.dart';
import 'package:http/http.dart' as http;

// class RoomController extends GetxController {
//   final people = <String>[].obs;
//   final roomName = ''.obs;
//
//   void addPerson(String email) {
//     if (email.trim().isNotEmpty && !people.contains(email)) {
//       people.add(email.trim());
//     }
//   }
//
//   void removePerson(String name) {
//     people.remove(name);
//   }
//
//   void setRoomName(String name) {
//     roomName.value = name;
//   }
//
//   // void createRoom() {
//   //   final room = Rooms(
//   //     name: roomName.value.isEmpty ? null : roomName.value,
//   //     people: people,
//   //   );
//   //   // Handle room creation logic here
//   //   Get.back(result: room);
//   // }
//
//
// Future<void> createRoom() async{
//     final name = roomName.value.trim();
//     String? token = await TokenStorage.getToken();
//     try{
//       final response = await http.post(
//         Uri.parse(ApiConstants.CREATE_ROOM),
//         headers: {
//           'Authorization': '$token',
//           'Content-Type': 'application/json',
//         },
//      //   body: jsonEncode(Room(name: 'Dev Room', members: ['123', '456']).toJson()),
//       );
//
//     }catch(e){
//       Get.snackbar('Error', 'Something went wrong: $e');
//     }
// }
//
// }




class RoomController extends GetxController {
  var people = <String>[].obs;
  var roomName = ''.obs;

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

      final data = jsonDecode(response.body);
      if (data['success'] == 1) {
        Get.back(); // Close bottom sheet
        Get.snackbar("Room Created", "Room '${roomName.value}' created successfully");
        people.clear();
        roomName.value = '';
      } else {
        Get.snackbar("Error", data['msg'] ?? "Failed to create room");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }
}



// class RoomController extends GetxController {
//
//   var isLoading = false.obs;
//   var rooms = <Room>[].obs;
//
//   /// ✅ Create Room API
//   Future<void> createRoom(String name, List<String> memberIds) async {
//     String? token = await TokenStorage.getToken();
//     isLoading.value = true;
//     final url = Uri.parse(ApiConstants.CREATE_ROOM);
//
//     try {
//       final response = await http.post(
//         url,
//         headers: {
//           'Authorization': '$token',
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({
//           'name': name,
//           'members': memberIds,
//         }),
//       );
//
//       final data = jsonDecode(response.body);
//
//       if (data['success'] == 1) {
//         Room room = Room.fromJson(data['body']);
//         rooms.add(room);
//         Get.snackbar("Success", "Room created successfully");
//       } else {
//         Get.snackbar("Error", data['msg'] ?? "Failed to create room");
//       }
//     } catch (e) {
//       Get.snackbar("Error", "An error occurred: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   /// ✅ Add Admin API
//   Future<void> createAdmin(String roomId, String userId) async {
//
//     String? token = await TokenStorage.getToken();
//     final url = Uri.parse(ApiConstants.CREATE_ADMIN);
//
//     try {
//       final response = await http.post(
//         url,
//         headers: {
//           'Authorization': '$token',
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({
//           'room_id': roomId,
//           'admin_member': userId,
//         }),
//       );
//
//       final data = jsonDecode(response.body);
//
//       if (data['success'] == 1) {
//         Get.snackbar("Success", "${data['body']['admin_name']} is now an admin");
//       } else {
//         Get.snackbar("Error", data['msg'] ?? "Failed to assign admin");
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Error assigning admin: $e");
//     }
//   }
//
//   /// ✅ Remove Admin API
//   Future<void> removeAdmin(String roomId, String userId) async {
//     String? token = await TokenStorage.getToken();
//     final url = Uri.parse(ApiConstants.REMOVE_ADMIN);
//
//     try {
//       final response = await http.put(
//         url,
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({
//           'room_id': roomId,
//           'admin_member': userId,
//         }),
//       );
//
//       final data = jsonDecode(response.body);
//
//       if (data['success'] == 1) {
//         Get.snackbar("Success", "Admin removed successfully");
//       } else {
//         Get.snackbar("Error", data['msg'] ?? "Failed to remove admin");
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Error removing admin: $e");
//     }
//   }
// }

