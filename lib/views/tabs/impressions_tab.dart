import 'package:flutter/material.dart';

class ImpressionsTab extends StatelessWidget{
  const ImpressionsTab ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No invites yet',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}