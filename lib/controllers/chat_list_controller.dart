import 'dart:async';
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

  RxInt selectedFilter = 0.obs;

  //final RxList<ChatItem> filteredChatList = <ChatItem>[].obs;
  final Map<String, bool> onlineUsers = {};
  final onlineUserIds = <String>{}.obs;
  Timer? onlineStatusTimer;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchChatList();
    //setupPresenceListener();
    setupSocketListeners();
    startStatusTimer();
    debounce(searchText, (_) => filterChatList(),
        time: Duration(milliseconds: 300));
  }

  @override
  void onClose() {
    onlineStatusTimer?.cancel();
    super.onClose();
  }

  void setSelectedFilter(int filter) {
    selectedFilter.value = filter;
    applyFilters();
  }

  void applyFilters() {
    var result = chatList;

    if (selectedFilter.value == 1) {
      result = result.where((item) => item.isUnread).toList().obs;
    }

    if (searchText.value.isNotEmpty) {
      result = result
          .where((item) => item.name
          .toLowerCase()
          .contains(searchText.value.toLowerCase()))
          .toList()
          .obs;
    }

    filteredChatList.value = result;
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
    final timestamp = data['created_at']; // Optional

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

  // void setupPresenceListener() {
  //   socketService.listenForUserPresence((userId, isOnline) {
  //     final index = filteredChatList.indexWhere((chat) => chat.userId == userId);
  //     if (index != -1) {
  //       filteredChatList[index].isOnline = isOnline;
  //       filteredChatList.refresh();
  //     }
  //   });
  // }

  void setupSocketListeners() {
    final socketService = Get.find<SocketService>();

    // socketService.socket?.on('user_online', (data) {
    //   final userId = data.toString();
    //   onlineUserIds.add(userId);
    //   _updateUserStatus(userId, true);
    // });
    //
    // socketService.socket?.on('user_left_message_page', (data) {
    //   final userId = data.toString();
    //   onlineUserIds.remove(userId);
    //   _updateUserStatus(userId, false);
    // });
    socketService.listenForPresenceUpdates((userId, isOnline) {
      if (isOnline) {
        onlineUserIds.add(userId);
      } else {
        onlineUserIds.remove(userId);
      }
      _updateUserStatus(userId, isOnline);
    });
  }

  void _updateUserStatus(String userId, bool isOnline) {
    final index = filteredChatList.indexWhere((u) => u.userId == userId);
    if (index != -1) {
      final user = filteredChatList[index];
      user.updateOnlineStatus(isOnline);
      filteredChatList[index] = user.copyWith(
        isOnline: user.isOnline,
        lastSeen: user.lastSeen,
      );
      filteredChatList.refresh();
    }else {
      print("User not found in filteredChatList: $userId");
    }
  }

  void startStatusTimer() {
    onlineStatusTimer = Timer.periodic(Duration(seconds: 30), (_) {
      final now = DateTime.now();
      for (var user in filteredChatList) {
        if (user.lastSeen != null) {
          final difference = now.difference(user.lastSeen!);
          user.isOnline = difference.inMinutes < 2;
        }
      }
      filteredChatList.refresh();
    });
  }

  // void startStatusTimer() {
  //   onlineStatusTimer?.cancel(); // ensure not duplicated
  //   onlineStatusTimer = Timer.periodic(Duration(seconds: 30), (_) {
  //     final now = DateTime.now();
  //     for (int i = 0; i < filteredChatList.length; i++) {
  //       final user = filteredChatList[i];
  //       if (user.lastSeen != null) {
  //         final diff = now.difference(user.lastSeen!);
  //         final isStillOnline = diff.inMinutes < 2;
  //
  //         if (user.isOnline != isStillOnline) {
  //           filteredChatList[i] = user.copyWith(
  //             isOnline: isStillOnline,
  //             lastSeen: user.lastSeen,
  //           );
  //         }
  //       }
  //     }
  //   });
  // }
}
