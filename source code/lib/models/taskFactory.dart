import 'package:flutter/material.dart';
import 'package:focusflow/models/Task.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


/* This is a factory that stores a static list of Appointments, 
where all methods referring to acting on appointments(delete them, add them, edit them) happen.
AppointmentsDataSource is a requirement from syncfusion calendar model. 
*/


class Taskfactory {

  //Lists
  static List<Appointment> _tasksForUser = [];
  static List<Appointment> get getTasksList => _tasksForUser;


  //Allows you to add the task to the Calendar
  static void addTaskToCal(Appointment task) {
    _tasksForUser.add(task);
    
  }

  //Deletes the task form the calendar, as well as the hash table.
  static void deleteTask(int id) {
    _tasksForUser.removeWhere((element) => element.id.hashCode == id);
  }

  //Repoints the appointment data for a given created task.
  static AppointmentDataSource getCalendarDataSource() {
    return AppointmentDataSource(_tasksForUser);
  }

  //Allows the editing of a created task. 
  static void editTaskToCal(int id, DateTime startDate, DateTime endDate,
      String title, bool isPriority, String category, int points) {
Task task=_tasksForUser.firstWhere((element) => element.id.hashCode == id)as Task;
task.subject=title;
task.startTime=startDate;
task.endTime=endDate;
task.setPriority=isPriority;
task.setCategory=category;
task.setPoints=points;



      }
}

  //Class containing the Appointment Data(extends Syncfusion calendar module to provide basic getters and setters,
  //could be used instead of TaskFactory, but I didn't care. can be easily translated to TaskFactory and back with 
  //having _tasksForUser as source(already defined) and other methods just same. Add this as a field to class "User" 
  //once you create it.)
class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  String getStartTimeZone(int index) {
    return appointments![index].startTimeZone;
  }

  @override
  String getEndTimeZone(int index) {
    return appointments![index].endTimeZone;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }
}
