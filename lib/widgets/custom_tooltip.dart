import 'package:flutter/material.dart';

import '../controllers/tooltip_controller.dart';

// class CustomTooltip extends StatelessWidget {
//   final String text;
//   final double xPosition;
//   final double yPosition;
//
//   const CustomTooltip({
//     Key? key,
//     required this.text,
//     required this.xPosition,
//     required this.yPosition,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       left: xPosition - 150, // Center the tooltip relative to icon
//       top: yPosition,
//       child: Material(
//         elevation: 4,
//         borderRadius: BorderRadius.circular(8),
//         child: Container(
//           width: 300,
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: Colors.grey.shade300),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 text,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   color: Colors.black87,
//                 ),
//               ),
//               // Add arrow at the top
//               Positioned(
//                 top: -8,
//                 left: 142,
//                 child: CustomPaint(
//                   painter: ArrowPainter(),
//                   size: const Size(16, 8),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // Arrow painter for tooltip
// class ArrowPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.fill;
//
//     final path = Path()
//       ..moveTo(0, size.height)
//       ..lineTo(size.width / 2, 0)
//       ..lineTo(size.width, size.height)
//       ..close();
//
//     canvas.drawPath(path, paint);
//
//     // Draw border
//     final borderPaint = Paint()
//       ..color = Colors.grey.shade300
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1;
//
//     canvas.drawPath(path, borderPaint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
//
// // Reusable Tooltip Icon Button
// class TooltipIconButton extends StatelessWidget {
//   final String tooltipText;
//   final GlobalKey iconKey;
//   final TooltipController controller;
//
//   TooltipIconButton({
//     Key? key,
//     required this.tooltipText,
//     required this.controller,
//   })  : iconKey = GlobalKey(),
//         super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       key: iconKey,
//       icon: const Icon(
//         Icons.help_outline,
//         size: 20,
//         color: Colors.grey,
//       ),
//       onPressed: () {
//         controller.showTooltip(tooltipText, context, iconKey);
//       },
//     );
//   }
// }





class CustomTooltip extends StatefulWidget {
  final Widget child;
  final String message;

  const CustomTooltip({required this.child, required this.message, Key? key}) : super(key: key);

  @override
  _CustomTooltipState createState() => _CustomTooltipState();
}

class _CustomTooltipState extends State<CustomTooltip> {
  OverlayEntry? _overlayEntry;
  final GlobalKey _key = GlobalKey();

  void _showTooltip(BuildContext context) {
    _hideTooltip(); // Ensure no duplicate tooltips

    final RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Background to detect taps outside tooltip
          Positioned.fill(
            child: GestureDetector(
              onTap: _hideTooltip, // Hide tooltip on tap outside
              behavior: HitTestBehavior.opaque,
              child: Container(),
            ),
          ),

          // Tooltip positioned above the icon
          Positioned(
            left: offset.dx - 70,
            right: offset.dx-70,
            top: offset.dy - 60, // Adjusted to appear above
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  //color: Colors.black87,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26, // Shadow color
                      blurRadius: 6, // Softness of the shadow
                      spreadRadius: 2, // How much the shadow spreads
                      offset: Offset(2, 2), // Shadow position (x, y)
                    ),
                  ],
                ),
                child: Text(
                  widget.message,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _key,
      onTap: () => _showTooltip(context), // Show tooltip on tap
      child: widget.child,
    );
  }
}


