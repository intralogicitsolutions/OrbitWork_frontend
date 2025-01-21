import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/routes/app_routes.dart';

import '../controllers/drawer_controller.dart';
import '../controllers/theme_controller.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        color: Colors.black.withOpacity(0.2),
        child: Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            child: Material(
              color: Colors.transparent,
              child: Container(
                height: screenHeight - statusBarHeight,
                padding: EdgeInsets.only(
                  top: statusBarHeight + 16,
                  left: 16,
                  right: 16,
                ),
                decoration:  BoxDecoration(
                 // color: Colors.white,
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          // backgroundImage:
                          // NetworkImage("https://via.placeholder.com/150"),
                          child: const Icon(Icons.account_circle, size: 48),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            Text(
                              "Ishita Poshiya",
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                              ),
                              // style: TextStyle(
                              //     fontSize: 18, fontWeight: FontWeight.bold,
                              // ),
                            ),
                            Text(
                              "Freelancer",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(height: 24, thickness: 1),
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        // Removes default padding from the ListView
                        itemCount: 10,
                        // Add 1 to account for the last item
                        itemBuilder: (context, index) {
                          // List of drawer options
                          final options = [
                            {'icon': Icons.person, 'title': 'Profile', 'trailingIcon': Icons.keyboard_arrow_right},
                            {'icon': Icons.bar_chart, 'title': 'My stats', 'trailingIcon': Icons.keyboard_arrow_right},
                            {'icon': Icons.receipt_long, 'title': 'Reports', 'trailingIcon': Icons.keyboard_arrow_right,},
                            {
                              'icon': Icons.request_page,
                              'title': 'My Requests',
                              'trailingIcon': Icons.open_in_new
                            },
                            {'icon': Icons.chat, 'title': 'Chat with Uma', 'trailingIcon': Icons.keyboard_arrow_right},
                            {'icon': Icons.apps, 'title': 'Apps and Offers', 'trailingIcon': Icons.keyboard_arrow_right},
                            {'icon': Icons.settings, 'title': 'Settings', 'trailingIcon': Icons.keyboard_arrow_right},
                            {'icon': Icons.help, 'title': 'Help & Support', 'trailingIcon': Icons.keyboard_arrow_right},
                            {
                              'icon': Icons.brightness_6,
                              'title': 'Theme: ${_getThemeLabel()}',
                              'trailingIcon': Icons.expand_more
                            },
                          ];

                          if (index < options.length) {
                            final option = options[index];
                            return _buildDrawerOption(
                              context: context,
                              option['icon'] as IconData,
                              option['title'] as String,
                              trailingIcon: option['trailingIcon'] as IconData?,
                              isBold: (option['isBold'] ?? false) as bool,
                              onTap: () {
                                if (option['title'] == 'Theme: ${_getThemeLabel()}') {
                                  Get.back();
                                  Get.find<Drawercontroller>().openBottomSheet(context);
                                } else if (option['title'] == 'Reports') {
                                  Get.toNamed(AppRoutes.reports);
                                }else {
                                  // Handle other options
                                }
                              },
                            );
                          }
                        },
                        separatorBuilder: (context, index) => Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: Wrap(
                            children: [
                              Icon(
                                Icons.logout,
                                color: Colors.green,
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                "Log out",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            "Version 1.1.0",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getThemeLabel() {
    final themeController = Get.find<ThemeController>();
    switch (themeController.themeMode.value) {
      case ThemeMode.light:
        return "Light";
      case ThemeMode.dark:
        return "Dark";
      default:
        return "System Default";
    }
  }

  Widget _buildDrawerOption(IconData icon, String title,
      {IconData? trailingIcon, bool isBold = false, VoidCallback? onTap, required BuildContext context}) {
    return ListTile(
      dense: true,
      minVerticalPadding: 0,
      horizontalTitleGap: 15.0,
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, size: 24,
          color: Theme.of(context).iconTheme.color,
          //color: Colors.black
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 16
        ),
        // style: TextStyle(
        //   fontSize: 16,
        //   fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        // ),
      ),
      trailing: trailingIcon != null
          ? Icon(trailingIcon, size: 20,
          //color: Colors.black
          color: Theme.of(context).iconTheme.color,
      )
          : null,
      onTap: onTap
      //     () {
      //   if (title.startsWith("Theme")) {
      //     Get.find<Drawercontroller>().openBottomSheet(); // Open theme bottom sheet
      //   }
      //   // Handle navigation or actions here
      // },
    );
  }
}
