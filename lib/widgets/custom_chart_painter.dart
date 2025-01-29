import 'package:flutter/material.dart';
import '../models/profile_metrics_model.dart';

class ChartPainter extends CustomPainter {
  final List<ProfileMetricsModel> data;
  final double maxValue;

  ChartPainter({required this.data, required this.maxValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 1;

    // Draw horizontal grid lines
    for (var i = 0; i <= maxValue; i += 3) {
      final y = size.height - (size.height * i / maxValue);
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }

    // Draw bars
    final barWidth = size.width / (data.length * 2);
    for (var i = 0; i < data.length; i++) {
      final barHeight = size.height * data[i].views / maxValue;
      final barPaint = Paint()
        ..color = data[i].isAvailableBadgeOn ? Colors.blue : Colors.cyan;

      canvas.drawRect(
        Rect.fromLTWH(
          i * (size.width / data.length),
          size.height - barHeight,
          barWidth,
          barHeight,
        ),
        barPaint,
      );

      // Draw date labels
      final textPainter = TextPainter(
        text: TextSpan(
          text: data[i].date,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          i * (size.width / data.length),
          size.height + 5,
        ),
      );
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}