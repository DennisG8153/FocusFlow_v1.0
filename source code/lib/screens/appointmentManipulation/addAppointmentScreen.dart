import 'package:flutter/material.dart';
import 'package:focusflow/models/Task.dart';
import 'package:focusflow/models/taskFactory.dart';


class addAppointmentScreen extends StatefulWidget {
  const addAppointmentScreen({super.key});
  static const String routeName = "/addAppoitnemnt";

  @override
  State<addAppointmentScreen> createState() => _addAppointmentScreenState();
}

/*This is the addAppointmentScreen, which allows you
to enter the info about the task/appointment and have it tied to the tasks/appointments list
within the calendar.
Subject to minor informational and visual change: add more fields of the Task object, 
add widgets to accomodate for the information, edit design.*/

class _addAppointmentScreenState extends State<addAppointmentScreen> {
  
  //key stores info in the form
  
  final _formKey = GlobalKey<FormState>();
//text controllers update when the info in the textfield change.
  final TextEditingController _textNameController = TextEditingController();
  int _intPointsController = 0;
  final TextEditingController _textCategoryController = TextEditingController();
  DateTime date = DateTime.now();

  bool _isPriority = false;
  //misc fields to make some coloration, should be changed to MaterialTheme in the main.dart
  Color _yesButtonColor = Colors.grey.shade300;
  Color _noButtonColor = Colors.grey.shade300;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _textNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(resizeToAvoidBottomInset:false,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.keyboard_backspace_outlined),
                ),
              ),
              Text("Enter the title of your task"),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: _textNameController,
                decoration: InputDecoration(labelText: 'Name of the task'),   
              ),
              Text('Points worth: $_intPointsController'),
              Slider(
                value: _intPointsController.toDouble(),
                onChanged: (double value) {
                  setState(() {
                    _intPointsController = value.round();
                  });
                },
                max: 100,
                divisions: 100,
              ),
              Text("Category Name"),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: _textCategoryController,
              ),
              Text("Pick time"),
              SizedBox(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 100,
                      child: Column(children: [
                        IconButton(
                            onPressed: () {
                              /*Calendar and clock buttons that open calendar and clock Material modules. 
                              Those two set the time task should begin at.*/
                              showDatePicker(
                                      context: context,
                                      currentDate: date,
                                      firstDate: DateTime(1990),                           
                                      lastDate: DateTime(2050))
                                  .then((DateTime? result) {
                                setState(() {
                                   if(result!=null)
                                  date = result;
                                });
                              });
                            },
                            icon: Icon(Icons.calendar_month)),
                        Text(
                            "Date picked:\n${date.toString().substring(0, 10)}"),
                      ]),
                    ),
                    SizedBox(
                      height: 100,
                      child: Column(children: [
                        IconButton(
                            onPressed: () {
                              showTimePicker(
                                      context: context, 
                                      initialTime: TimeOfDay.now())       //Time Picker
                                  .then((TimeOfDay? result) {
                                setState(() {
                                  if(result!=null) {
                                    date = date.copyWith(
                                      hour: result.hour,
                                      minute: result.minute);
                                  }
                                });
                                
                              });
                            },
                            icon: Icon(Icons.timer)),
                        Text("Time picked:\n${date.hour}:${date.minute < 10
                                ? "0${date.minute}"
                                : date.minute.toString()}"),
                      ]),
                    ) 
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Text("Is this task a priority?")),
              SizedBox(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll<Color>(_yesButtonColor)),
                        onPressed: () {
                          _isPriority = true;                                                     //Task Priority buttons(work, but look for alternative in SfCalendar.)
                          setState(() {
                            _yesButtonColor = Colors.purple;
                            _noButtonColor = Colors.grey.shade300;
                          });
                        },
                        child: Text("Yes!")),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll<Color>(_noButtonColor)),
                        onPressed: () {
                          _isPriority = false;
                          setState(() {
                            _yesButtonColor = Colors.grey.shade300;
                            _noButtonColor = Colors.purple;
                          });
                        },
                        child: Text("NAH!"))
                    /*After those clock and data widgets you need to have another two of them:end data of the appointment*/
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                      onPressed: () {//checking if what is entered is valid, shows snackbar with a message, adds a task to the list.
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                          Taskfactory.addTaskToCal(Task(
                            startTime: date,
                            endTime: date,
                            subject: _textNameController.text,

                            _isPriority,
                            _textCategoryController.text,
                            _intPointsController,
                            //add checks for this
                          ));
                          Navigator.of(context).pop(context);
                        }
                      },
                      child: Text("ADD TASK")))
            ],
          ),
        ),
      ),
    );
  }
}
