import 'dart:math';
import 'package:flutter/material.dart';

class HexagonClipper extends CustomClipper<Path> {
  final double cornerRadius;

  HexagonClipper({this.cornerRadius = 6.0});

  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    final path = Path();

    final points = [
      Offset(w * 0.5, 0),          // top center
      Offset(w, h * 0.25),        // top right
      Offset(w, h * 0.75),        // bottom right
      Offset(w * 0.5, h),         // bottom center
      Offset(0, h * 0.75),        // bottom left
      Offset(0, h * 0.25),        // top left
    ];

    final roundedPath = Path();
    for (int i = 0; i < points.length; i++) {
      final p1 = points[i];
      final p2 = points[(i + 1) % points.length];
      final p0 = points[(i - 1 + points.length) % points.length];

      // Direction vectors
      final v1 = (p1 - p0).direction;
      final v2 = (p2 - p1).direction;

      // Points inward for rounding
      final p1Start = p1 - Offset.fromDirection(v1, cornerRadius);
      final p1End = p1 + Offset.fromDirection(v2, cornerRadius);

      if (i == 0) {
        roundedPath.moveTo(p1Start.dx, p1Start.dy);
      } else {
        roundedPath.lineTo(p1Start.dx, p1Start.dy);
      }

      // Rounded corner with quadratic Bézier
      roundedPath.quadraticBezierTo(p1.dx, p1.dy, p1End.dx, p1End.dy);
    }

    roundedPath.close();
    return roundedPath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
