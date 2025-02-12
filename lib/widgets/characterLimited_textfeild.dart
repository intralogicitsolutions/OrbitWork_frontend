import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CharacterLimitedTextField extends StatelessWidget {
  final TextEditingController controller;
  final RxInt remainingCharacters;
  final int maxCharacters;
  final Function(String) onChanged;
  final String hintText;

  const CharacterLimitedTextField({
    Key? key,
    required this.controller,
    required this.remainingCharacters,
    required this.maxCharacters,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          maxLines: 1,
          maxLength: maxCharacters,
          keyboardType: TextInputType.multiline,
          scrollPhysics: BouncingScrollPhysics(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
            counterText: "",
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            isDense: true,
          ),
        ),
        SizedBox(height: 8),
        Obx(() => Align(
          alignment: Alignment.centerRight,
          child: Text(
            '${remainingCharacters.value} characters left',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        )),
      ],
    );
  }
}
