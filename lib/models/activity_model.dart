import 'package:flutter/cupertino.dart';

class ActivityModel {
  final String title;
  final String subtitle;
  final String date;
  final IconData icon;
  final Color iconColor;

  ActivityModel(
     {required this.title,
       required this.subtitle,
       required this.date,
       required this.icon,
       required this.iconColor, });
}