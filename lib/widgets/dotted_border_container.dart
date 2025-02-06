import 'package:flutter/material.dart';

class DottedBorderContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const DottedBorderContainer({
    Key? key,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 250,
        width: double.infinity,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(250),
        //   border: Border.all(
        //     color: Colors.grey,
        //     width: 1,
        //     style: BorderStyle.solid,
        //   ),
        // ),
        child: CustomPaint(
          painter: DottedBorderPainter(),
          child: Center(child: child),
        ),
      ),
    );
  }
}


class DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    double dashWidth = 2;
    double dashSpace = 1;
    double startAngle = 0;
    final double radius = size.width / 2.5;
    final Offset center = Offset(size.width / 2, size.height / 2);

    while (startAngle < 360) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle * (3.14159 / 180),
        dashWidth * (3.14159 / 180),
        false,
        paint,
      );
      startAngle += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}