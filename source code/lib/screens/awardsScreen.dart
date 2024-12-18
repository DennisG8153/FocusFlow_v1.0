import 'package:flutter/material.dart';

class awardsScreen extends StatefulWidget {
  const awardsScreen({super.key});

  @override
  State<awardsScreen> createState() => _awardsScreenState();
}

/*Mockup screen for the page with list of all awards. */

class _awardsScreenState extends State<awardsScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: const Center(
        child: Text('Unimplemented for now, come back soon...'
        , style: TextStyle(
          color: Colors.black, 
          fontSize: 40.0))
      )
      

      
       
    );
  }
}