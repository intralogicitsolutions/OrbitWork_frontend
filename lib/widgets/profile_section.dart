import 'package:flutter/material.dart';

class ProfileSection extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback? onEdit;
  final bool isAdd;

  const ProfileSection({
    Key? key,
    required this.title,
    required this.child,
    this.onEdit,
    this.isAdd = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              if (onEdit != null)
                IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.green),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isAdd ? Icons.add : Icons.edit,
                      color: Colors.green,
                      size: 16,
                    ),
                  ),
                  onPressed: onEdit,
                ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}