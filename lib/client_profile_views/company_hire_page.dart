import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CompanyHirePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildContainer('An idea machine'),
            _buildContainer('A pleasure to work with'),
            _buildContainer('Your 5-star favorite'),
            SizedBox(height: 12,),
            Text('No one at your company has hired anyone yet. Add teammates to help you hire faster.')
          ],
        ),
      ),
    );
  }

  Widget _buildContainer(String text){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 32),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey.shade200
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icon/user.svg',
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
            Text(text,style: TextStyle(
                fontSize: 16,color: Colors.grey.shade600
            ),)
          ],
        ),
      ),
    );
  }

}