import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SimpleSelectionBottomSheet extends StatelessWidget {
  final String title;
  final List<String> options;
  final Function(String) onSelect;

  const SimpleSelectionBottomSheet({
    super.key,
    required this.title,
    required this.options,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...options.map((item) => ListTile(
            title: Text(item),
            onTap: () {
              onSelect(item);
              Get.back();
            },
          )),
        ],
      ),
    );
  }
}
