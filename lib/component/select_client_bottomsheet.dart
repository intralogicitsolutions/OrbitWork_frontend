import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/clients_controller.dart';

class SelectClientsBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SelectClientsController>();
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Client',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          // Search bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Search clients...',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (query) {
              controller.updateSearchQuery(query);
            },
          ),
          const SizedBox(height: 12),
          // List of clients with checkboxes
          Obx(() {
            final filteredClients = controller.filteredClients;

            return Expanded(
              child: ListView.builder(
                itemCount: filteredClients.length,
                itemBuilder: (context, index) {
                  int clientIndex = controller.clients.indexOf(filteredClients[index]);
                  return ListTile(
                    leading: Obx(() => Checkbox(
                      value: controller.selectedClients[clientIndex],
                      onChanged: (bool? value) {
                        controller.toggleClientSelection(clientIndex);
                      },
                    )),
                    title: Text(filteredClients[index]),
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
