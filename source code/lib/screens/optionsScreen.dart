import 'package:flutter/material.dart';

class optionsScreen extends StatelessWidget {
  const optionsScreen({super.key});

  /*This is the currently half-implemented options screen. 
  This is where one would access the settings for our app if
  they were implemented, as well as logout from the app.
  Currently only contains a button with either option.*/

  @override
  Widget build(BuildContext context) {
    void handleClick(String value) {
    switch (value) {
      case 'Logout':
        break;
      case 'Settings':
        break;
    }
  }
    return  Center(
      child: PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Logout', 'Settings'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
    );
  }
}