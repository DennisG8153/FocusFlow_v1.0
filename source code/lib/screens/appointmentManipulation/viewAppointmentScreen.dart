import 'package:flutter/material.dart';
import 'package:focusflow/models/Task.dart';
import 'package:focusflow/models/taskFactory.dart';
import 'package:focusflow/screens/appointmentManipulation/editAppointmentScreen.dart';

class viewAppointmentScreen extends StatefulWidget {
  const viewAppointmentScreen({super.key});
  static const String routeName = "/viewAppointment";
  @override
  State<viewAppointmentScreen> createState() => _viewAppointmentScreenState();
}

/*A mockup screen that allows you to see task info.
Recommendation: just make a normal design, man. @taskToView is the task you are viewing, just make it look nice.
*/

class _viewAppointmentScreenState extends State<viewAppointmentScreen> {
  late bool isCompleteSwitchValue;
  @override
  Widget build(BuildContext context) {
    final Task taskToView = ModalRoute.of(context)!.settings.arguments as Task;   
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: () {
                  setState(() {
                    Taskfactory.deleteTask(taskToView.id.hashCode);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Event deleted!'),                //Icon Button to delete a task, as well as display a message when Deleted. 
                        backgroundColor: Colors.red,
                      ),
                    );
                    Navigator.pop(context);
                  });
                },
                icon: Icon(Icons.delete)),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: () {
                  setState(() {
                    Navigator.pushNamed(
                        context, editAppointmentScreen.routeName,     //Icon button that allows you to edit a task via the editAppointmentScreen
                        arguments: taskToView);
                  });
                },
                icon: Icon(Icons.edit)),
          ),
          Switch(
              value: taskToView.isComplete,
              onChanged: (value) {
                setState(() {
                  taskToView.setIsComplete = value;                   //Icon Button that allows you to set a task to complete.
                });
              })
        ],
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(taskToView.subject),
            subtitle: Text(taskToView.getCategory),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(taskToView.notes ?? "No notes"),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Time of the event:"),                //Contains the data for the task, organized in several rows and columns of info. 
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("from: "),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text("to: "),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        '${taskToView.startTime.toString().substring(0, 10)}\n${taskToView.startTime.toString().substring(10, 19)}'),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                        '${taskToView.endTime.toString().substring(0, 10)}\n${taskToView.endTime.toString().substring(10, 19)}'),
                  )
                ],
              ),
            ),
          ),
          Text("Is it complete?${taskToView.isComplete ? " Yes." : " No."}")
        ],
      ),
    );
  }
}
