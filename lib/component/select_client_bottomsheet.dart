import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/clients_controller.dart';

class SelectClientsBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Accessing the controller to manage the state
    final controller = Get.find<SelectClientsController>();

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Search clients...',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (query) {
              controller.updateSearchQuery(query); // Update search query
            },
          ),
          SizedBox(height: 12),
          // List of clients with checkboxes
          Obx(() {
            // Get filtered clients based on search query
            final filteredClients = controller.filteredClients;

            return Expanded(
              child: ListView.builder(
                itemCount: filteredClients.length,
                itemBuilder: (context, index) {
                  int clientIndex = controller.clients.indexOf(filteredClients[index]);
                  return ListTile(
                    leading: Checkbox(
                      value: controller.selectedClients[clientIndex],
                      onChanged: (bool? value) {
                        controller.toggleClientSelection(clientIndex); // Toggle selection
                      },
                    ),
                    title: Text(filteredClients[index]),
                    onTap: () {
                      // Optionally handle onTap logic if needed
                    },
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
