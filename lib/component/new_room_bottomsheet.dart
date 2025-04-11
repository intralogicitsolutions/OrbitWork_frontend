import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/room_controller.dart';

class NewRoomBottomSheet extends StatelessWidget {
  final controller = Get.put(RoomController());
  final TextEditingController nameController = TextEditingController();

  NewRoomBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.scaffoldBackgroundColor,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                ),
                const Text(
                  'New room',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                  onPressed: () => controller.createRoom(),
                  child: const Text('Create room'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Add people',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            // Display chips
            Obx(() => Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: controller.people
                      .map((name) => Chip(
                            label: Text(name),
                            backgroundColor: Colors.grey[300],
                            deleteIcon: Icon(Icons.close),
                            onDeleted: () => controller.removePerson(name),
                          ))
                      .toList(),
                )),

            const SizedBox(height: 8),

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Type email & press space/enter',
                hintStyle: TextStyle(color: Colors.grey),
                //filled: true,
                // fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onChanged: (value) {
                if (value.endsWith(' ') || value.endsWith('\n')) {
                  final name = value.trim();
                  if (name.isNotEmpty) {
                    controller.addPerson(name);
                    nameController.clear();
                  }
                }
              },
              onSubmitted: (value) {
                final name = value.trim();
                if (name.isNotEmpty) {
                  controller.addPerson(name);
                  nameController.clear();
                }
              },
            ),

            const SizedBox(height: 24),
            Row(
              children: [
                const Text(
                  'Room name',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  '(Optional)',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter a name',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              //onChanged: (value) => controller.setRoomName(value),
              onChanged: controller.setRoomName,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
