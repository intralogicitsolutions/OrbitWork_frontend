import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../comms/url_launcher_helper.dart';

class AgencyProfile extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
     appBar: AppBar(
       title: Text('Agency profile', style: TextStyle(
         fontSize: 18, fontWeight: FontWeight.w500
       ),),
       actions: [
         IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded))
       ],
     ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade400)),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Create agency', style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w500
                  ),),
                  SizedBox(
                    height: 16,
                  ),
                  RichText(text: TextSpan(
                    style: TextStyle(
                      color: theme.secondaryHeaderColor, fontSize: 16,
                      height: 1.5
                    ),
                    children: [
                      TextSpan(
                        text: 'Agencies allow for multiple freelancers on a single team and often have business managers. Create an agency if you plan to work this way.'
                      ),
                      TextSpan(
                        text: 'Learn more',style: TextStyle(
                        color: theme.primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: theme.primaryColor
                      ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => UrlLauncherHelper.openUrl('https://www.google.com'),
                      )
                    ]
                  ),),
                  SizedBox(
                    height: 16,
                  ),
                  Text('Agency name',style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500
                  ),),
                  SizedBox(height: 10,),
                  Container(
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      ),
                    ),
                  ),
                  Divider(height: 32,),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                              side: BorderSide(
                                  color: theme.primaryColor
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text('Cancel', style: TextStyle(
                              color: theme.primaryColor
                            ),)),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ElevatedButton(onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Colors.grey[200],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)
                                )
                            ),
                            child: Text('Continue', style: TextStyle(
                                color: Colors.grey[700]
                            ),)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
   );
  }

}