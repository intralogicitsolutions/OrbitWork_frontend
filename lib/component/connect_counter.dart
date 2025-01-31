
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConnectCounter extends StatelessWidget {
  final int value;
  final Function(int) onChanged;
  final bool isEditing;
  final Function() onToggleEdit;
  final Function() onSubmit;
  final TextEditingController textController;
  final FocusNode focusNode;
  static const int MIN_CONNECTS = 14;

  const ConnectCounter({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.isEditing,
    required this.onToggleEdit,
    required this.onSubmit,
    required this.textController,
    required this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Decrease button (Disabled if value is at minimum)
          IconButton(
            icon: Icon(
              Icons.remove_circle_outline,
              color: value <= MIN_CONNECTS ? Colors.grey : Colors.green,
            ),
            onPressed: value <= MIN_CONNECTS ? null : () => onChanged(value - 1),
          ),

          // Display text / Editable TextField
          isEditing
              ? SizedBox(
            width: 50,
            child: TextField(
              controller: textController,
              focusNode: focusNode,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              autofocus: true,
              showCursor: true,
              cursorColor: Colors.green,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                isDense: true,
                // contentPadding: EdgeInsets.symmetric(
                //   horizontal: 8,
                //   vertical: 8,
                // ),
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
              ),
              onChanged: (text) {
                int? newValue = int.tryParse(text);
                if (newValue != null) {
                  onChanged(newValue);
                }
              },
              onSubmitted: (_) => onSubmit(),
            ),
          )
              : GestureDetector(
            onTap: onToggleEdit,
            child: Text(
              '$value',
              style: TextStyle(
                fontSize: 16,
                decoration: TextDecoration.underline,
                color: Colors.green,
              ),
            ),
          ),

          // Increase button
          IconButton(
            icon: Icon(Icons.add_circle_outline, color: Colors.green),
            onPressed: () => onChanged(value + 1),
          ),

          // Dynamic Text based on value
          Text(
            value < MIN_CONNECTS
                ? 'min $MIN_CONNECTS Connects per week'
                : 'Connects per week',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}