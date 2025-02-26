import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_tooltip/super_tooltip.dart';
import '../../controllers/tooltip_controller.dart';

class GlobalTooltip extends StatelessWidget {
  final String text;
  final Color? iconColor;
  final double? iconSize;
 // final TooltipController controller = Get.put(TooltipController());

  GlobalTooltip({required this.text, this.iconColor, this.iconSize});

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
        child: Obx(() => Text(
          controller.tooltipText.value,
          style: TextStyle(color: Colors.black),
        )),
      ),
      child: SizedBox(
        height: 24,
        width: 24,
        child: IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          onPressed: () {
            if (controller.tooltipController.isVisible) {
              controller.hideTooltip();
            } else {
              controller.showTooltip(text);
            }
          },
          icon: Icon(Icons.help_outline, color: iconColor,size: iconSize,),
        ),
      ),
    );
  }
}
