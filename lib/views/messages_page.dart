import 'package:flutter/material.dart';

import '../widgets/custom_appbar.dart';

class MessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: "Message",
        rightIcon: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: theme.dividerColor,
              // color: Colors.black,
              width: 1,
            ),
          ),
          child: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              print("Notifications clicked");
            },
          ),
        ),
      ),
      body: Column(
        children: [
          Wrap(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search for jobs",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: IconButton(
                      icon: Icon(Icons.filter,
                        color: Colors.green,
                        // color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                  )

                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
