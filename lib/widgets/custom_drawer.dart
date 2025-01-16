import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight = MediaQuery.of(context).size.height;

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
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  children: [
                    // Profile Section
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundImage:
                          NetworkImage("https://via.placeholder.com/150"),
                          child: const Icon(Icons.account_circle, size: 48),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Ishita Poshiya",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Freelancer",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(height: 24, thickness: 1),

                    // Drawer Options
                    Expanded(
                      child: ListView(
                        children: [
                          _buildDrawerOption(Icons.person, "Profile"),
                          _buildDrawerOption(Icons.bar_chart, "My stats"),
                          _buildDrawerOption(Icons.receipt_long, "Reports"),
                          _buildDrawerOption(
                            Icons.request_page,
                            "My Requests",
                            trailingIcon: Icons.open_in_new,
                          ),
                          _buildDrawerOption(Icons.chat, "Chat with Uma"),
                          _buildDrawerOption(
                              Icons.apps, "Apps and Offers"),
                          _buildDrawerOption(Icons.settings, "Settings"),
                          _buildDrawerOption(
                              Icons.help, "Help & Support"),
                          _buildDrawerOption(
                            Icons.brightness_6,
                            "Theme: Light",
                            trailingIcon: Icons.expand_more,
                          ),
                          const Divider(height: 24, thickness: 1),
                          _buildDrawerOption(
                            Icons.logout,
                            "Log out",
                            isBold: true,
                          ),
                        ],
                      ),
                    ),

                    // Version Info
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Version 1.1.0",
                        style: TextStyle(color: Colors.grey),
                      ),
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

  Widget _buildDrawerOption(IconData icon, String title,
      {IconData? trailingIcon, bool isBold = false}) {
    return ListTile(
      leading: Icon(icon, size: 24, color: Colors.black),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: trailingIcon != null
          ? Icon(trailingIcon, size: 20, color: Colors.grey)
          : null,
      onTap: () {
        // Handle navigation or actions here
      },
    );
  }
}
