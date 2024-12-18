import 'package:flutter/material.dart';
import 'package:focusflow/models/Reward.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

/*This is the Task model, it extends class Appointment that 
comes from syncfusion calendar module(see imports). 
Appointment requires AppointmentData class, which is in /taskfactory.dart*/

class Task extends Appointment {
  //vars
  String _name = "";

  String _category = "";

  bool _priority = false;

  int _points = 0;

  bool _isComplete = false;
  //constructor

  Task(bool this._priority, this._category, int this._points,
      {required super.startTime,
      required super.endTime,
      required super.subject}) {
    this.color = _isComplete ? Colors.green : Colors.red;
  }

  //setters and getters

  String get getName {
    return _name;
  }

  set setCategory(String s) {
    _category = s;
  }

  String get getCategory => _category;
  set setName(String n) {
    n = _name;
  }

  bool get isComplete => _isComplete;

  set setIsComplete(bool b) {
    //should be made either a function or the second line should be transferred to a separate function. Keep the design clean.
    _isComplete = b;
    this.color = _isComplete ? Colors.green : Colors.red;
  }

  bool get isPriority {
    return _priority;
  }

  set setPriority(bool pr) {
    pr = _priority;
  }

  int get getPoints {
    return _points;
  }

  set setPoints(int t) {
    t = _points;
  }
}
