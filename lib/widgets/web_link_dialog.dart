import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profile/add_portfolio_controller.dart';

class WebLinkBottomSheet extends StatelessWidget {
  final AddPortfolioController controller = Get.put(AddPortfolioController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      padding: EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
        // Add padding for bottom keyboard
      //  bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: 8),
          Text(
            'Only one link can be added at a time.',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Paste a web link to an article or website',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12),
          _buildLinkInput(),
          SizedBox(height: 16),
          _buildGuidelinesLink(),
          SizedBox(height: 24),
          _buildButtons(),
          // Safe area for bottom notch devices
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Add a web link',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Get.back(),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
        ),
      ],
    );
  }

  Widget _buildLinkInput() {
    return TextField(
      onChanged: (value) => controller.updateWebLink(value),
      decoration: InputDecoration(
        hintText: 'Article or website link',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      autofocus: true, // Automatically show keyboard
    );
  }

  Widget _buildGuidelinesLink() {
    return InkWell(
      onTap: () {
        // Handle guidelines tap
      },
      child: Row(
        children: [
          Icon(
            Icons.open_in_new,
            color: Colors.green,
            size: 20,
          ),
          SizedBox(width: 8),
          Text(
            'Does your link meet Upwork\'s guidelines?',
            style: TextStyle(
              color: Colors.green,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.green,
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Obx(() => ElevatedButton(
            onPressed: controller.isAddButtonEnabled.value
                ? () {
              if (controller.isValidUrl(controller.webLink.value)) {
                Get.back(result: controller.webLink.value);
              }
            }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Add',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          )),
        ),
      ],
    );
  }
}
