import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/role_controller.dart';
import '../enum/user_role_enum.dart';
import '../routes/app_routes.dart';


class SelectProfilePage extends StatelessWidget {
  final RoleController controller = Get.put(RoleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Join as a client or freelancer', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),),
            SizedBox(height: 12,),
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildRoleOption(
                  icon: Icons.business_center,
                  title: "I'm a client,\nhiring for a project",
                  role: UserRole.CLIENT,
                  selected: controller.selectedRole.value == UserRole.CLIENT,
                  onTap: () => controller.selectRole(UserRole.CLIENT),
                ),
                _buildRoleOption(
                  icon: Icons.person,
                  title: "I'm a freelancer,\nlooking for work",
                  role: UserRole.FREELANCER,
                  selected: controller.selectedRole.value == UserRole.FREELANCER,
                  onTap: () => controller.selectRole(UserRole.FREELANCER),
                ),
              ],
            )),

            const SizedBox(height: 30),
            // Dynamic Button
            Obx(() {
              final selected = controller.selectedRole.value;
              String buttonText = 'Create Account';
              if (selected == UserRole.CLIENT) {
                buttonText = 'Join as a client';
              } else if (selected == UserRole.FREELANCER) {
                buttonText = 'Apply as a freelancer';
              }

              return SizedBox(
               // width: double.infinity,
                child: ElevatedButton(
                  onPressed: selected == null
                      ? null
                      : () {
                    print('Selected role: $selected');
                    Get.toNamed(AppRoutes.signup, arguments: selected);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selected != null ? Colors.green : Colors.grey,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade200,
                    disabledForegroundColor: Colors.grey.shade500,
                  ),
                  child: Text(buttonText),
                ),
              );
            }),

            const SizedBox(height: 20),

            // Log In prompt
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? ", style: TextStyle(
                    fontSize: 14
                ),),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.login);
                  },
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRoleOption({
    required IconData icon,
    required String title,
    required UserRole role,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(border: Border.all(width: 1),
      borderRadius: BorderRadius.circular(6)),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, size: 30),
               SizedBox(width: 16.0,),
                Icon(
                  selected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: selected ? Colors.green : Colors.grey,
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 130,
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  color: selected ? Colors.black : Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
