import 'package:flutter/material.dart';
import 'package:focusflow/screens/mainScreen.dart';
import 'package:focusflow/screens/calendarScreen.dart';
import 'package:focusflow/screens/awardsScreen.dart';
import 'package:focusflow/screens/optionsScreen.dart';


/*Main page of the application. Maintains the bottom appbar and the switch between five pages.*/

class homePage extends StatefulWidget {
  const homePage({super.key});
  static const String nameRoute = "/home";

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(         //Appbar on the top with the unimplemented profile button. 
                  elevation: 0, shadowColor: Colors.white),
              onPressed: () {},
              child: Icon(Icons.person))
        ],
      ),
      //Bottom navigational bar, contains all the destinations for the other screens. 
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.calendar_month),
            label: "Calendar",
          ),
          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Home Page",                     
          ),
          NavigationDestination(
              icon: Icon(Icons.add_chart_outlined), label: "Awards"),
          NavigationDestination(
            icon: Icon(Icons.menu),
            label: "Menu",
          )
        ],
      ),
      
      
      body: <Widget>[//screens change depending on what icon you have picked 
                    //on the Appbar(that is what the currentPageIndex down there is doing.)
                    //Remember: order in which they exist matters!
        calendarScreen(),
        mainScreen(),
        awardsScreen(),
        optionsScreen(),
      ][currentPageIndex],
    );
  }
}
