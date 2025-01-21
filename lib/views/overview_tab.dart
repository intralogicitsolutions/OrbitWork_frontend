import 'package:flutter/material.dart';

class OverviewTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        itemCount: 4,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              _getTitle(index),
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
            subtitle: Text('\$0.00'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {},
          );
        },
        separatorBuilder: (context, index) {
          return Divider( height: 0,
            thickness: 1,
            color: Colors.grey.withOpacity(0.3),);
        },
      ),
    );
  }
  String _getTitle(int index) {
    switch (index) {
      case 0:
        return 'Work in progress';
      case 1:
        return 'In review';
      case 2:
        return 'Pending';
      case 3:
        return 'Available';
      default:
        return '';
    }
  }
}
