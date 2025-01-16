import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;

  const CustomTextField({required this.hintText, this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            hintText,
          textAlign: TextAlign.start,
        ),
        TextField(
          decoration: InputDecoration(
           // hintText: hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }

}