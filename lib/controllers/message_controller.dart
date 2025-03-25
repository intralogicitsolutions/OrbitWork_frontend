import 'package:get/get.dart';
import '../models/message_model.dart';

class MessageController extends GetxController {
  var messages = <MessagesModel>[].obs;
  var filteredMessages = <MessagesModel>[].obs;
  var searchQuery = ''.obs;
  RxBool isLoading = true.obs;

  var filterSelected = "".obs;
  final isFilterMenuVisible = false.obs;

  var selectedFilter = 0.obs;
  var isContractExpanded = false.obs;
  var isOtherExpanded = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMessages();
  }

  void fetchMessages() async{
    await Future.delayed(Duration(seconds: 2));
    messages.value = [
      MessagesModel(
        name: "Quentin Leopold, kfzBlitz24 GmbH",
        title: "Flutter App Developer",
        lastMessage: "You: Quentin Leopold",
        date: "12/27/24",
      ),
      MessagesModel(
        name: "John Doe",
        title: "React Developer",
        lastMessage: "You: Thanks for the update!",
        date: "12/26/24",
      ),
    ];
    isLoading.value = false;
    filteredMessages.value = messages;
  }

  void filterMessages(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredMessages.value = messages;
    } else {
      filteredMessages.value = messages
          .where((message) =>
      message.name.toLowerCase().contains(query.toLowerCase()) ||
          message.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void toggleFilterMenu() {
    isFilterMenuVisible.value = !isFilterMenuVisible.value;
  }



  void toggleContract() {
    isContractExpanded.value = !isContractExpanded.value;
  }

  void toggleOther() {
    isOtherExpanded.value = !isOtherExpanded.value;
  }

  void setSelectedFilter(int value) {
    selectedFilter.value = value;
    print("Selected Filter: $value");
    // Handle filtering logic here
  }
}