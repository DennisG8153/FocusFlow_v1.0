import 'package:flutter/material.dart';
import 'package:focusflow/models/Task.dart';
import 'package:focusflow/models/taskFactory.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


/*THIS FORM IS OBSOLETE. High recommendation to edit "addAppointmentScreen.dart" to accomodate for editing the info.
The structure is absolutely the same. Further commentary redundant.*/


class editAppointmentScreen extends StatefulWidget {
  const editAppointmentScreen({super.key});
  static const String routeName = "/editAppointment";
  @override
  State<editAppointmentScreen> createState() => _editAppointmentScreenState();
}

class _editAppointmentScreenState extends State<editAppointmentScreen> {

  //vars
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  late DateTime initialDate;
   DateTime? date=null;
  bool _isPriority = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Task taskToEdit = ModalRoute.of(context)!.settings.arguments as Task;

    Color yesButtonColor = Colors.grey.shade300;
    Color noButtonColor = Colors.grey.shade300;
    initialDate = taskToEdit.startTime;
    
   
    //Scaffold containing all of the task editing functionality. 
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit task"),
        actions: [
          IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                  //Ties editTaskToCal function from TaskFactory to the data that will be acquired here. 
                  Taskfactory.editTaskToCal(
                    taskToEdit.id.hashCode,
                    (date??initialDate) == taskToEdit.startTime ? taskToEdit.startTime : date!,
                    (date??initialDate) == taskToEdit.endTime ? taskToEdit.endTime : date!,
                    _titleController.text == taskToEdit.subject
                        ? taskToEdit.subject
                        : _titleController.text,

                    _isPriority == taskToEdit.isPriority              
                        ? taskToEdit.isPriority
                        : _isPriority,
                    _categoryController.text == taskToEdit.subject
                        ? taskToEdit.subject
                        : _categoryController.text,
                    0,
                    //add checks for this
                  );
                  Navigator.of(context).pop(context);
                }
              },
              icon: Icon(Icons.send))
        ],
      ),
      body: Form(
          key: _formKey,
          child: Column(                                  
            children: [

              //Title Text Controller, edits the name of the task
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Title",
                    style: TextStyle(fontSize: 20),
                  )),
              TextFormField(
                validator: (value) {
                  if (value != taskToEdit.subject) if ((value == null ||
                      value.isEmpty)) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: _titleController,
               
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: taskToEdit.subject),
              ),  
              
              //Category Text controller, edits the category of the task.
              Align(
                  alignment: Alignment.bottomLeft,                                               
                  child: Text(
                    "Category",
                    style: TextStyle(fontSize: 20),
                  )),
              TextFormField(
                validator: (value) {
                  if (value != taskToEdit.getCategory) if ((value == null ||
                      value.isEmpty)) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: _categoryController,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: taskToEdit.getCategory),
              ),
              
              //Date input edit for the task. 
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Date:(only one date for now)",
                  style: TextStyle(fontSize: 20),
                ),
              ),

              //Time input edit for the task 
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
                              showDatePicker(
                                      context: context,
                                      currentDate: date,
                                      initialDate: initialDate,
                                      firstDate: DateTime(1990),                            
                                      lastDate: DateTime(2050))
                                  .then((DateTime? result) {
                                setState(() {
                                  if (result != initialDate) {
                                    if (result != null && result != "")                                                        
                                      date = result;
                                  }
                                });
                              });
                            },
                            icon: Icon(Icons.calendar_month)),
                        Text(
                            "Date picked:\n${(date??initialDate).toString().substring(0, 10)}"),
                      ]),
                    ),
                    SizedBox(
                      height: 100,
                      child: Column(children: [
                        IconButton(
                            onPressed: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(
                                          initialDate))
                                  .then((TimeOfDay? result) {
                                setState(() {
                                  if (result != initialDate && result != null) {
                                    date=initialDate;
                                    date = date!.copyWith(
                                        hour: result.hour,
                                        minute: result.minute);
                                  }
                                });
                              });
                            },
                            icon: Icon(Icons.timer)),
                        Text(
                            "Time picked:\n${date?.hour??initialDate.hour}:${(date?.minute??initialDate.minute) < 10 ? "0${date?.minute??initialDate.minute}" :( date?.minute??initialDate.minute).toString()}"),
                      ]),
                    ) /*Put calendar and clock dialogs here*/
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
                            backgroundColor:                                                               //Priority setting editor
                                WidgetStatePropertyAll<Color>(yesButtonColor)),
                        onPressed: () {
                          _isPriority = true;
                          setState(() {
                            yesButtonColor = Colors.purple;
                            noButtonColor = Colors.grey.shade300;
                          });
                        },
                        child: Text("Yes!")),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll<Color>(noButtonColor)),
                        onPressed: () {
                          _isPriority = false;
                          setState(() {
                            yesButtonColor = Colors.grey.shade300;
                            noButtonColor = Colors.purple;
                          });
                        },
                        child: Text("NAH!"))
                    /*Put calendar and clock dialogs here*/
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
