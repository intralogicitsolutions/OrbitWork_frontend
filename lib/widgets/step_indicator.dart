import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepIndicator({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        return Expanded(
          child: Container(
            height: 4,
            margin: EdgeInsets.symmetric(horizontal: 0),
            decoration: BoxDecoration(
              color: index <= currentStep ? Colors.black : Colors.grey[300],
              borderRadius: BorderRadius.circular(0),
            ),
          ),
        );
      }),
    );
  }
}