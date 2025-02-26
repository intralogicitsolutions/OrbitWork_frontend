import 'package:flutter/material.dart';

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


