import 'package:flutter/material.dart';

class DottedBorderContainerRectangle extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const DottedBorderContainerRectangle({
    Key? key,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        width: double.infinity,
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
      ..color = Colors.green
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    double dashWidth = 4;
    double dashSpace = 2;
   // double startAngle = 0;

    // Draw a rectangle with dotted border
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Draw the horizontal lines
    for (double x = rect.left; x < rect.right; x += dashWidth + dashSpace) {
      canvas.drawLine(Offset(x, rect.top), Offset(x + dashWidth, rect.top), paint);
      canvas.drawLine(Offset(x, rect.bottom), Offset(x + dashWidth, rect.bottom), paint);
    }

    // Draw the vertical lines
    for (double y = rect.top; y < rect.bottom; y += dashWidth + dashSpace) {
      canvas.drawLine(Offset(rect.left, y), Offset(rect.left, y + dashWidth), paint);
      canvas.drawLine(Offset(rect.right, y), Offset(rect.right, y + dashWidth), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
