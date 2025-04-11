import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../global/tokenStorage.dart';
import '../models/chat_item_model.dart';
import '../repository/api/api_constants.dart';
import '../socket/socket_service/socket_service.dart';

class ChatListController extends GetxController {
  final chatList = <ChatItem>[].obs;
  final filteredChatList = <ChatItem>[].obs;
  final searchText = ''.obs;
  final isLoading = false.obs;
  final socketService = Get.put(SocketService());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchChatList();
    debounce(searchText, (_) => filterChatList(),
        time: Duration(milliseconds: 300));
    socketService.listenToGroupMessages((data) {
      print("Real-time message received in ChatListController: $data");
      _handleNewMessage(data);
    });
  }

  Future<void> fetchChatList() async {
    isLoading.value = true;
    String? token = await TokenStorage.getToken();

    try {
      var url = Uri.parse(ApiConstants.GET_CHAT_LIST);

      // Add headers and token if required
      var response = await http.get(
        url,
        headers: {
          'Authorization': '$token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> body = json.decode(response.body);
        chatList.value = body.map((item) => ChatItem.fromJson(item)).toList();
        filterChatList();

        chatList.value = body.map((item) => ChatItem.fromJson(item)).toList();
      } else {
        print("Error fetching chat list: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchChatList: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void filterChatList() {
    if (searchText.value.isEmpty) {
      filteredChatList.assignAll(chatList);
    } else {
      filteredChatList.assignAll(chatList.where((item) =>
          item.name.toLowerCase().contains(searchText.value.toLowerCase())));
    }
  }

  void _handleNewMessage(dynamic data) {
    // Assuming `data` contains room_id and message text
    final message = data['message'] ?? '';
    final roomId = data['room_id'] ?? '';
    final timestamp = data['timestamp']; // Optional

    final index = chatList.indexWhere((chat) => chat.roomId == roomId);
    if (index != -1) {
      final updatedChat = chatList[index].copyWith(
        roomId: roomId,
        messageWithPrefix: message,
        createdAt: timestamp ?? DateTime.now().toString(),
      );
      chatList[index] = updatedChat;
      chatList.refresh(); // Notify UI
      filterChatList();
    } else {
      // Optionally refetch or add new chat item
      fetchChatList();
    }
  }
}
