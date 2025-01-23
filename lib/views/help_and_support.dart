import 'package:flutter/material.dart';

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
           ),
           HelpAndSuooprtTile(
             icon: Icons.help_outline,
             title: "Orbitwork general support",
             onTap: () => {},
           ),
           HelpAndSuooprtTile(
             icon: Icons.groups,
             title: "Community & forums",
             onTap: () => {},
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

  const HelpAndSuooprtTile({
    this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:icon != null ?  Icon(icon ?? null) : null,
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle?? '') : null,
      trailing: Icon(Icons.open_in_new, size: 18),
      onTap: onTap,
    );
  }
}