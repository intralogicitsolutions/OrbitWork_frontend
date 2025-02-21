import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../component/add_extra_layres_security_bottomsheet.dart';
import '../routes/app_routes.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: ListView(
          children: [
            // Billing Section
            SectionTitle(title: "Billing"),
            SettingsTile(
              icon: Icons.attach_money,
              title: "Billing & payments",
              onTap: () {
                Get.toNamed(AppRoutes.billingAndPayments);
              },
            ),

            // User Settings Section
            SectionTitle(title: "User settings"),
            SettingsTile(
              icon: Icons.card_membership,
              title: "Membership & Connects",
              onTap: () {
                Get.toNamed(AppRoutes.membershipAndConnects);
              },
            ),
            SettingsTile(
              icon: Icons.contact_page,
              title: "Contact info",
              onTap: () {
                Get.toNamed(AppRoutes.contactInfo);
              },
            ),
            SettingsTile(
              icon: Icons.account_balance_wallet,
              title: "Tax information",
              onTap: () {
                Get.bottomSheet(
                  AddExtraLayersSecurityBottomsheet(),
                  isScrollControlled: true,
                  ignoreSafeArea: false,
                );
              },
            ),
            SettingsTile(
              icon: Icons.file_copy,
              title: "Tax forms",
              onTap: () {
                Get.toNamed(AppRoutes.taxForm);
              }
            ),
            SettingsTile(
              icon: Icons.person,
              title: "Profile settings",
              onTap: () {
                Get.toNamed(AppRoutes.profileSetting);
              }
            ),
            SettingsTile(
              icon: Icons.payment,
              title: "Get paid",
              onTap: () =>  Get.toNamed(AppRoutes.getPaid),
            ),
            SettingsTile(
              icon: Icons.group,
              title: "My teams",
              onTap: () => Get.toNamed(AppRoutes.myTeams),
            ),
            SettingsTile(
              icon: Icons.security,
              title: "Password & security",
              onTap: () {
                Get.toNamed(AppRoutes.passwordAndSecurity);
              }
            ),
            SettingsTile(
              icon: Icons.verified_user,
              trailingIcon: Icons.open_in_new,
              title: "Identity verification",
              onTap: () => print("Identity verification"),
            ),
            SettingsTile(
              icon: Icons.restore,
              title: "Restore purchases",
              onTap: () => print("Restore purchases"),
            ),
            SettingsTile(
              icon: Icons.privacy_tip,
              title: "Privacy preferences",
              onTap: () {
                Get.toNamed(AppRoutes.privacyPreferences);
              },
            ),

            SectionTitle(title: "Notification settings"),
            SettingsTile(
              icon: Icons.notifications_none,
              title: "Notifiaction settings",
              onTap: () => {Get.toNamed(AppRoutes.notificationSettings)},
            ),

            SectionTitle(title: "Account management and control"),
            SettingsTile(
              title: "Close account",
              subtitle: "This will permanently close your account.",
              onTap: () => Get.toNamed(AppRoutes.closeAccount),
            ),
            SettingsTile(
              title: "Delete personal data",
              subtitle: "We'll ask you for some necessary information to get started on your request. We will process your request in accordance with our privacy policy and applicable laws. ",
              onTap: () => {},
            ),

            SectionTitle(title: "Legal"),
            SettingsTile(
              icon: Icons.event_note_outlined,
              title: "Privacy policy",
              trailingIcon: Icons.open_in_new,
              onTap: () => {},
            ),
            SettingsTile(
              icon: Icons.accessible,
              title: "Accessibility",
              trailingIcon: Icons.open_in_new,
              onTap: () => {},
            ),
            SettingsTile(
              icon: Icons.miscellaneous_services_outlined,
              trailingIcon: Icons.open_in_new,
              title: "Terms of service",
              onTap: () => {},
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;

  const SectionTitle({required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final IconData? trailingIcon;

  const SettingsTile({
    this.icon,
    required this.title,
    required this.onTap,
    this.subtitle, this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:icon != null ?  Icon(icon ?? null) : null,
      title: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
      subtitle: subtitle != null ? Text(subtitle?? '') : null,
      trailing: trailingIcon != null ?  Icon(trailingIcon ?? null) : Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}