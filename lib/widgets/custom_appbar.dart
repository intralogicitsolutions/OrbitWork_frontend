import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/drawer_controller.dart';

import 'custom_drawer.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? rightIcon; // Optional right icon (can be null)
  final bool isBackButtonEnabled;
  final bool isProfile;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.rightIcon,
    this.isBackButtonEnabled = false,
    this.isProfile = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Drawercontroller drawerController = Get.find<Drawercontroller>();
    final theme = Theme.of(context);

    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 80,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (isBackButtonEnabled) {
                Get.back();
              } else {
                Get.dialog(
                  GestureDetector(
                    onTap: () {
                      drawerController.closeDrawer();
                      Future.delayed(
                        const Duration(milliseconds: 300),
                            () => Get.back(),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(color: Colors.black.withOpacity(0.5)),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: FractionallySizedBox(
                            widthFactor: 0.8,
                            child: SlideTransition(
                              position: drawerController.slideAnimation,
                              child: CustomDrawer(isProfilePage: isProfile,),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  barrierDismissible: false,
                  barrierColor: Colors.transparent,
                );
                drawerController.openDrawer();
              }
            },
            child: CircleAvatar(
              radius: 24,
              child: const Icon(Icons.account_circle, size: 48),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
          const Spacer(),
          if (rightIcon != null) rightIcon!, // Display right icon if provided
        ],
      ),
      backgroundColor: theme.appBarTheme.backgroundColor,
      elevation: 0,
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
}
