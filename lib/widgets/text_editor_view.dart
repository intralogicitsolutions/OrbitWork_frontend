import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profile/add_portfolio_controller.dart';

class TextEditorView extends StatelessWidget {
  final AddPortfolioController controller = Get.put(AddPortfolioController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Visibility(
      visible: controller.isTextEditorVisible.value,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            _buildActionBar(),
            _buildEditorTypeSelector(),
            _buildHeadingField(),
            _buildContentField(),
          ],
        ),
      ),
    ));
  }

  Widget _buildActionBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_upward, color: Colors.grey),
                onPressed: () => controller.moveBlockUp(0),
              ),
              IconButton(
                icon: Icon(Icons.arrow_downward, color: Colors.grey),
                onPressed: () => controller.moveBlockDown(0),
              ),
              IconButton(
                icon: Icon(Icons.delete_outline, color: Colors.grey),
                onPressed: () => controller.deleteBlock(0),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.close, color: Colors.grey),
            onPressed: () => controller.toggleTextEditor(),
          ),
        ],
      ),
    );
  }

  Widget _buildEditorTypeSelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => controller.isMarkdownMode.value = false,
              child: Column(
                children: [
                  Text(
                    'Plain text',
                    style: TextStyle(
                      color: !controller.isMarkdownMode.value
                          ? Colors.black
                          : Colors.grey,
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    height: 2,
                    color: !controller.isMarkdownMode.value
                        ? Colors.black
                        : Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => controller.isMarkdownMode.value = true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Markdown',
                    style: TextStyle(
                      color: controller.isMarkdownMode.value
                          ? Colors.black
                          : Colors.grey,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeadingField() {
    return Container(
      padding: EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Heading',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          border: InputBorder.none,
        ),
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        onChanged: (value) => controller.heading.value = value,
      ),
    );
  }

  Widget _buildContentField() {
    return Container(
      padding: EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Enter your text',
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
        maxLines: null,
        onChanged: (value) => controller.currentText.value = value,
      ),
    );
  }
}