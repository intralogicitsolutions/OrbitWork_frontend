import 'package:get/get.dart';
import '../models/room_model.dart';

class RoomController extends GetxController {
  final people = <String>[].obs;
  final roomName = ''.obs;

  void addPerson(String name) {
    people.add(name);
  }

  void removePerson(String name) {
    people.remove(name);
  }

  void setRoomName(String name) {
    roomName.value = name;
  }

  void createRoom() {
    final room = Room(
      name: roomName.value.isEmpty ? null : roomName.value,
      people: people,
    );
    // Handle room creation logic here
    Get.back(result: room);
  }

  void clearData() {
    people.clear();
    roomName.value = '';
  }
}