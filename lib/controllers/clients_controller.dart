import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectClientsController extends GetxController {
  RxList<String> clients = RxList<String>([
    'All Clients',
    'abc',
    'def',
    'xyz',
    'test',
  ]);

  RxList<bool> selectedClients = RxList<bool>([false, false, false, false, false, false]);

  RxString searchQuery = ''.obs;

  RxBool selectAll = false.obs;

  void toggleClientSelection(int index) {
    if (index == 0) {
      selectAll.value = !selectAll.value;
      for (int i = 1; i < selectedClients.length; i++) {
        selectedClients[i] = selectAll.value;
      }
    } else {
      selectedClients[index] = !selectedClients[index];
      selectAll.value = selectedClients.skip(1).every((element) => element);
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  List<String> get filteredClients {
    if (searchQuery.value.isEmpty) {
      return clients;
    } else {
      return clients.where((client) => client.toLowerCase().contains(searchQuery.value.toLowerCase())).toList();
    }
  }
}
