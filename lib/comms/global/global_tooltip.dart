import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_tooltip/super_tooltip.dart';
import '../../controllers/tooltip_controller.dart';

class GlobalTooltip extends StatelessWidget {
 // final String text;
  final Color? iconColor;
  final double? iconSize;
  final Widget? child;
  final Widget content;

  GlobalTooltip({required this.content, this.iconColor, this.iconSize, this.child,});

  @override
  Widget build(BuildContext context) {

    final TooltipController controller = Get.put(TooltipController(), tag: UniqueKey().toString());

    return SuperTooltip(
      controller: controller.tooltipController,
      popupDirection: TooltipDirection.up,
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
      borderRadius: 8.0,
      showCloseButton: false,
      hasShadow: false,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        // child: Obx(() => Text(
        //   controller.tooltipText.value,
        //   style: TextStyle(color: Colors.black),
        // )),
        child: content,
      ),

      child: GestureDetector(
        onTap: () {
          if (controller.tooltipController.isVisible) {
            controller.hideTooltip();
          } else {
            controller.showTooltip();
          }
        },
        child: child ??
            SizedBox(
              height: 24,
              width: 24,
              child: Icon(Icons.help_outline, color: iconColor, size: iconSize),
            ),
      ),
    );
  }
}
