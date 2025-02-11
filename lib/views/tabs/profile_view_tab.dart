
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/profile_matrics_controller.dart';
import '../../models/profile_metrics_model.dart';


class ProfileViewsTab extends GetView<ProfileMetricsController> {
  //const ProfileViewsTab({Key? key}) : super(key: key);
  final ProfileMetricsController controller = Get.put(
      ProfileMetricsController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          GetX<ProfileMetricsController>(
            builder: (_) => Text(
              '${controller.totalViews.value} profile views',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              height: 150,
              child:
              // GetX<ProfileMetricsController>(
              //   builder: (_) =>
                    CustomPaint(
                  size: const Size(double.infinity, 200),
                  painter: ChartPainter(
                    data: controller.metricsData,
                    maxValue: 6,
                  ),
                ),
             // ),
            ),
          ),
          const SizedBox(height: 40),
          _buildLegend(),
          const SizedBox(height: 30),
          _buildAvailabilityBadgeInfo(context),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLegendItem(
              color: const Color(0xFF40E0D0),
              text: 'Available now badge is off',
            ),
            const SizedBox(height: 12),
            _buildLegendItem(
              color: Colors.blue,
              text: 'Available now badge is on',
            ),
           // const SizedBox(height: 16),
           //  InkWell(
           //    onTap: () {},
           //    child: const Text(
           //      'My profile',
           //      style: TextStyle(
           //        color: Colors.green,
           //        fontSize: 16,
           //        fontWeight: FontWeight.w500,
           //      ),
           //    ),
           //  ),
          ],
        ),
        InkWell(
          onTap: () {},
          child: const Text(
            'My profile',
            style: TextStyle(
              color: Colors.green,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem({required Color color, required String text}) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildAvailabilityBadgeInfo(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: theme.hoverColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.lightbulb_outline, color: Colors.green),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text:  TextSpan(
                style: TextStyle(fontSize: 12, color: theme.hintColor),
                children: [
                  TextSpan(text: 'With the '),
                  TextSpan(
                    text: 'availability badge',
                    style: TextStyle(color: Colors.green),
                  ),
                  TextSpan(text: ', you can signal to clients that you\'re ready for new work now '),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChartPainter extends CustomPainter {
  final List<ProfileMetricsModel> data;
  final double maxValue;

  ChartPainter({
    required this.data,
    required this.maxValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawGridLines(canvas, size);
    _drawBars(canvas, size);
  }

  void _drawGridLines(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 1;

    final textStyle = TextStyle(
      color: Colors.grey[600]!,
      fontSize: 12,
    );

    for (var i = 0; i <= maxValue; i += 3) {
      final y = size.height - (size.height * i / maxValue);

      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );

      final textSpan = TextSpan(text: i.toString(), style: textStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(-20, y - textPainter.height / 2));
    }
  }

  void _drawBars(Canvas canvas, Size size) {
    final barWidth = size.width / (data.length * 3);

    for (var i = 0; i < data.length; i++) {
      final barHeight = size.height * data[i].views / maxValue;
      final barX = i * (size.width / data.length) +
          (size.width / data.length - barWidth) / 2;

      // Draw bar
      final barPaint = Paint()..color = const Color(0xFF40E0D0);
      canvas.drawRect(
        Rect.fromLTWH(
          barX,
          size.height - barHeight,
          barWidth,
          barHeight,
        ),
        barPaint,
      );

      // Draw date label
      final textSpan = TextSpan(
        text: data[i].date,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 12,
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          barX - (textPainter.width - barWidth) / 2,
          size.height + 5,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
