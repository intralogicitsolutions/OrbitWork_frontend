import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType = TextInputType.text;
  final  bool obscureText = false;
  final Widget? suffixIcon;

  const CustomTextField({required this.label, this.onChanged, this.suffixIcon});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text(
        //   label,
        //   textAlign: TextAlign.start,
        // ),
        TextField(
          // decoration: InputDecoration(
          //  // hintText: hintText,
          //   border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          // ),
          decoration: InputDecoration(
            labelText: label,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            suffixIcon: suffixIcon,
          ),
          onChanged: onChanged,
          keyboardType: keyboardType,
          obscureText: obscureText,
        ),
      ],
    );
  }

}