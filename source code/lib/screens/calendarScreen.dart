import 'package:flutter/material.dart';

import 'package:focusflow/models/taskFactory.dart';
import 'package:focusflow/screens/appointmentManipulation/addAppointmentScreen.dart';
import 'package:focusflow/screens/appointmentManipulation/viewAppointmentScreen.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


/*The calendar screen is the only more or less completed part of the app. 
It shows tasks with a package syncfusion_flutter_calendar.
Data for the tasks is in models/taskFactory.dart and a Task is defined in models/Task.dart.
Recommendation: more or less leave it alone. Take a look at syncfusion API to change how the calendar looks.*/


class calendarScreen extends StatefulWidget {
  const calendarScreen({super.key});

  @override
  State<calendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<calendarScreen> {

  //calendar controller that allows you to access the updated data in the calendar.
  final CalendarController _controller = CalendarController();
  //current mode of the calendar. To change it, change CalendarView.month to something else.
  CalendarView _calendarView = CalendarView.month;

  //obsolete setState, I did't touch it because I might have needed it.
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState

    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Card(
                child: SfCalendar(//beginning of the Calendar widget
              onTap: (calendarTapDetails) {//this is where we register taps on calendar and specifically - appointments. 
                if (calendarTapDetails.targetElement !=
                        CalendarElement.calendarCell &&     
                    calendarTapDetails.targetElement !=
                        CalendarElement.appointment) {
                  return;
                }
                setState(() {//setState is here so it redraws itself once you have edited the appointment in the viewAppointmentScreen
                  if (_calendarView == CalendarView.month) {
                    _calendarView = CalendarView.day;
                  } else {                                                    //Displays the data for a given day on the lower part of the screens. Contains the tasks organized by time. 
                    if (calendarTapDetails.appointments!.length == 1 &&
                        calendarTapDetails.targetElement ==
                            CalendarElement.appointment) {
                      Navigator.pushNamed(context,                                
                              viewAppointmentScreen.routeName,    
                              arguments: calendarTapDetails.appointments![0])     //Tapping the appointment will allow you to view the appointment via the viewAppointmentScreen. 
                          .then((context) {
                        setState(() {});
                      });
                    }
                  }
                });
              },

              //Calendar settings
              monthViewSettings: MonthViewSettings(showAgenda: true),
              view: _calendarView,
              controller: _controller,
              dataSource: Taskfactory.getCalendarDataSource(),
            )),
          ),
          
          //Button that sends you towards the addAppointmentScreen for Task Creation.
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, addAppointmentScreen.routeName)
                      .then((value) {
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Added the appointment!'), backgroundColor: Colors.green,),      //Allows you to create the tasks via the addAppointmentScreen.
                      );
                    });
                  });
                },
                child: Icon(Icons.add)),
          )
        ],
      ),
    );
  }
}
