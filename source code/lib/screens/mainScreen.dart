import 'package:flutter/material.dart';
import 'package:focusflow/models/Task.dart';
import 'package:focusflow/models/taskFactory.dart';
import 'package:focusflow/screens/appointmentManipulation/editAppointmentScreen.dart';
import 'package:focusflow/screens/appointmentManipulation/viewAppointmentScreen.dart';
import 'package:focusflow/screens/calendarScreen.dart';
import 'package:intl/intl.dart';

/*Mockup of the main screen. All the data pipelines were established, just show the appointments in there.
Refer to design document for the design decisions.*/

class mainScreen extends StatefulWidget {
  const mainScreen({super.key});

  @override
  State<mainScreen> createState() => _HomePageState();
}


class _HomePageState extends State<mainScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 1,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),                                 //Top sized box containing the Date
              child: Row(
                children: [
                  Expanded(
                      flex: 4,
                      child: SizedBox(
                          width: size.width,
                          child: ListTile(
                              title: Text("Today's Date"),subtitle: Text("${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().year}", style: TextStyle(fontSize: 36)),
                              leading: IconButton(iconSize: 40,
                                  onPressed: () {}, icon: Icon(Icons.access_time)))))
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: PageView(
                children: [
                  SizedBox(
                      width: size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: Taskfactory.getTasksList.length,
                          itemBuilder:(context, index) {
                            try{
                              return ExpansionTile(title: Text('Category$index'),                 //Expanded lists with all tasks and categories from the calendar. 
                                children: 
                                  [TextButton
                                  (onPressed: () {
                                    Navigator.pushNamed(
                                      context, viewAppointmentScreen.routeName,
                                      arguments:Taskfactory.getTasksList[index],
                                    );
                                  },
                                  child: Text(Taskfactory.getTasksList[index].subject))]);
                            }
                            catch(e){
                              return Text(e.toString());
                            }
                            
                          }
                        ),
                      )),
                 
                ],
              ),
            )
          ),
        )
      ],
    );
  }
  
}
