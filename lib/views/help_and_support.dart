import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../component/client_profile/rate_bottomsheet.dart';

class HelpAndSupportPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text('Help & Support'),
     ),
     body: Padding(
       padding: const EdgeInsets.only(left: 4.0),
       child: ListView(
         children: [
           HelpAndSuooprtTile(
             icon: Icons.phone_android,
             title: "App support",
             onTap: () => {},
             trailingIcon: true,
           ),
           HelpAndSuooprtTile(
             icon: Icons.help_outline,
             title: "Orbitwork general support",
             onTap: () => {},
             trailingIcon: true,
           ),
           HelpAndSuooprtTile(
             icon: Icons.groups,
             title: "Community & forums",
             onTap: () => {},
             trailingIcon: true,
           ),
           HelpAndSuooprtTile(
             icon: Icons.feedback_outlined,
             title: "Feedback",
             onTap: () => {
             Get.bottomSheet(
               Container(
                 height: Get.height*0.3,
                   child: RateBottomsheet()),
            isScrollControlled: true,
             ),
             },
             trailingIcon: false,
           ),
         ],
       ),
     )
   );
  }

}

class HelpAndSuooprtTile extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final bool trailingIcon;

  const HelpAndSuooprtTile({
    this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.trailingIcon = false
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:icon != null ?  Icon(icon ?? null) : null,
      title: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
      subtitle: subtitle != null ? Text(subtitle?? '') : null,
      trailing: trailingIcon == true ? Icon(Icons.open_in_new, size: 18) : null,
      onTap: onTap,
    );
  }
}