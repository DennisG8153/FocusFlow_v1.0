import 'package:flutter/material.dart';
import 'package:focusflow/homePage.dart';
import 'package:focusflow/screens/appointmentManipulation/addAppointmentScreen.dart';
import 'package:focusflow/screens/appointmentManipulation/editAppointmentScreen.dart';
import 'package:focusflow/screens/appointmentManipulation/viewAppointmentScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Focus Flow',
        theme: ThemeData(
          // This is the theme of your application.
          // Use it if to change different aspects of the application.
          
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
          useMaterial3: true,
        ),
        home: const homePage(),
        routes: { //Routes to pages that allow Navigation to them(Navigator.pushNamed)
          homePage.nameRoute: (context) => const homePage(),
          addAppointmentScreen.routeName: (context) => addAppointmentScreen(),
          viewAppointmentScreen.routeName:(context)=>viewAppointmentScreen(),
          editAppointmentScreen.routeName:(context)=>editAppointmentScreen()
        });
  }
}
