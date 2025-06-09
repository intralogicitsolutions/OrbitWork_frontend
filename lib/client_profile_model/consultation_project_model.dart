import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConsultationItem {
  final String name;
  final String initials;
  final double rating;
  final String date;
  final String duration;
  final String description;
  final Color color;

  ConsultationItem({
    required this.name,
    required this.initials,
    required this.rating,
    required this.date,
    required this.duration,
    required this.description,
    required this.color,
  });
}


class ServiceProvider {
  final String name;
  final double rating;
  final int reviews;
  final String title;
  final String price;
  final String imageUrl;
  final String profileImage;
  final bool isTopRatedPlus;
  final String badge;

  late  RxBool isSaved;

  ServiceProvider({
    required this.name,
    required this.rating,
    required this.reviews,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.profileImage,
    required this.isTopRatedPlus,
    required this.badge,
    bool isInitiallySaved  = false,
  }) {
    isSaved = RxBool(isInitiallySaved);
  }
}