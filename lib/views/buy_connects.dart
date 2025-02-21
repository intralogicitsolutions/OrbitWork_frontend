import 'package:flutter/material.dart';

class BuyConnects extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final theme =  Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy Connects', style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w500
        ),),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Buy Connects', style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500,
              ),),
              SizedBox(height: 24,),
              Text('Your available Connects',style: TextStyle(fontSize: 16),),
              SizedBox(height: 24,),
              Text('0'),
              SizedBox(height: 30,),
              Text('Select the amount to buy', style: TextStyle(fontSize: 16),)
            ],
          ),
        ),
      ),
    );
  }

}