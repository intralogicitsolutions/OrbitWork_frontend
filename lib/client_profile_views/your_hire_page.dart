import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class YourHirePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return
     Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildContainer('AS absolute lifesaver'),
            _buildContainer('A long-term collaborator'),
            _buildContainer('Your go-to problem solver'),
            SizedBox(height: 12,),
            Text('You haven’t hired anyone yet. Start searching for the right fit for your next project.')
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