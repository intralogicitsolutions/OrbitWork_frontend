import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/availability_badge_controller.dart';
import 'connect_counter.dart';

class BadgeBottomSheet extends StatelessWidget {
  final BadgeController controller = Get.put(BadgeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Turn on availability badge',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Badge preview
            Center(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.pink[100],
                      child: Icon(Icons.person_outline),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Available Now',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'You had no profile views in the last 7 days.',
              style: TextStyle(color: Colors.grey[600]),
            ),
            Text(
              'Freelancers with significant profile views get the best use out of this badge.',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Text(
              'Ads are a proven way to win more work.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Freelancers who turn on their badge receive up to 50% more invites.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'The price to turn on the badge can change, so we\'ll turn the badge off automatically if the price exceeds your maximum.',
              style: TextStyle(color: Colors.grey[600]),
            ),
            TextButton(
              onPressed: () {
                // Handle "How does this work?" click
              },
              child: Text(
                'How does this work?',
                style: TextStyle(color: Colors.green),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Current Price',
              style: TextStyle(color: Colors.grey[600]),
            ),
            Obx(() => Text(
                  '${controller.badge.value.currentPrice} Connects per week',
                  style: TextStyle(fontSize: 16),
                )),
            SizedBox(height: 16),
            Text(
              'My maximum',
              style: TextStyle(color: Colors.grey[600]),
            ),
            // Obx(() => ConnectCounter(
            //   value: controller.badge.value.maximumConnects,
            //   onChanged: controller.updateMaximumConnects,
            // )),
            Obx(() => ConnectCounter(
                  value: controller.badge.value.maximumConnects,
                  onChanged: controller.updateMaximumConnects,
                  isEditing: controller.badge.value.isEditing,
                  onToggleEdit: controller.toggleEditing,
                  onSubmit: controller.submitValue,
                  textController: controller.textController,
                  focusNode: controller.focusNode,
                )),
            SizedBox(height: 8),
            Obx(() => Text(
                  'You have ${controller.badge.value.availableConnects} Connects.',
                  style: TextStyle(color: Colors.grey[600]),
                )),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    child: Text('Cancel'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.green,
                      side: BorderSide(color: Colors.green),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      //padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: controller.turnOnBadge,
                    child: Text('Turn on'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      //padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Usage example:
void showBadgeBottomSheet() {
  Get.bottomSheet(
    BadgeBottomSheet(),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}
