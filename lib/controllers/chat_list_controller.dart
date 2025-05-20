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

  //RxInt selectedFilter = 0.obs;
  final selectedFilter = 0.obs;

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
    debounce(searchText, (_) => filterChatList(),
        time: Duration(milliseconds: 300));
  }

  @override
  void onClose() {
    onlineStatusTimer?.cancel();
    super.onClose();
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
       // filterChatList();
        applyFilters();

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

  void applyFilters() {
    List<ChatItem> list = [...chatList];

    // Apply switch-case filter
    switch (selectedFilter.value) {
      case 1: // Unread
       // filteredChatList.assignAll(chatList.where((item) => item.unread == true));
        list = list.where((item) => item.unread == true).toList();
        break;
      // case 2: // Favorite (if you support favorites)
      //   filteredChatList.assignAll(chatList.where((item) => item.isFavorite == true));
      //   break;
      // case 3: // All Contracts (example)
      //   filteredChatList.assignAll(chatList.where((item) => item.isContract == true));
      //   break;
      default:
      // Show all if no filter
        //filteredChatList.assignAll(chatList);
        break;
    }

    // Apply search filter
    if (searchText.isNotEmpty) {
      list = list
          .where((item) =>
          item.name.toLowerCase().contains(searchText.value.toLowerCase()))
          .toList();
    }

    filteredChatList.assignAll(list);
    //filteredChatList.value = list;
  }


  void setSelectedFilter(int value) {
    selectedFilter.value = value;
    applyFilters();
  }

  void clearFilter() {
    selectedFilter.value = 0;
    applyFilters();
  }





  void setupSocketListeners() {
    final socketService = Get.find<SocketService>();
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
}
