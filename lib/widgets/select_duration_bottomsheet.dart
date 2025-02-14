import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showDurationBottomSheet(BuildContext context, Function(String) onSelect) {
  final theme = Theme.of(context);

  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Select Duration",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Column(
            children: ["Last 7 days", "Last 30 days", "Last 90 days"]
                .map(
                  (option) => ListTile(
                title: Text(option),
                onTap: () {
                  onSelect(option);
                  Get.back();
                },
              ),
            )
                .toList(),
          ),
        ],
      ),
    ),
    isScrollControlled: true,
  );
}
