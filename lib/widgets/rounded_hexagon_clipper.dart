import 'dart:math';

import 'package:flutter/material.dart';

class RoundedHexagonClipper extends CustomClipper<Path> {
  final double cornerRadius;

  RoundedHexagonClipper({this.cornerRadius = 4.0});

  @override
  Path getClip(Size size) {
    final double w = size.width;
    final double h = size.height;
    final double r = min(w, h) / 2;
    final Offset center = Offset(w / 2, h / 2);
    final double angle = pi / 3; // 60 degrees

    final path = Path();
    final List<Offset> points = List.generate(6, (i) {
      final double theta = angle * i - pi / 2; // start from top
      return Offset(center.dx + r * cos(theta), center.dy + r * sin(theta));
    });

    for (int i = 0; i < 6; i++) {
      final Offset p1 = points[i];
      final Offset p2 = points[(i + 1) % 6];

      final Offset direction = (p2 - p1);
      final Offset offsetStart = p1 + direction * (cornerRadius / direction.distance);
      final Offset offsetEnd = p2 - direction * (cornerRadius / direction.distance);

      if (i == 0) {
        path.moveTo(offsetStart.dx, offsetStart.dy);
      } else {
        path.lineTo(offsetStart.dx, offsetStart.dy);
      }

      path.quadraticBezierTo(p2.dx, p2.dy, offsetEnd.dx, offsetEnd.dy);
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

