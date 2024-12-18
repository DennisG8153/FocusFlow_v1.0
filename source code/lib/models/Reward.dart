import 'package:flutter/material.dart';

/* this is the Reward model, 
which will be used once implemented as a field of the class User.
It is meant to be the incentive for 
task creation within the application,
giving out after a user reaches a certain
set of conditions to warrant a reward.import*/

class Reward {
  //vars
  String _name = "";

  String _description = "";

  Image _badge;

  DateTime _completion ;

  bool _isClaimed;

  //constructor

  Reward(String this._name, String this._description, Image this._badge,
       this._completion,  bool this._isClaimed);

  //setters and getters

  String get getName {
    return _name;
  }

  set setName(String n) {
    n = _name;
  }

  String get getDescription {
    return _description;
  }

  set setDescription(String d) {
    d = _description;
  }

  Image get getBadge {
    return _badge;
  }

  set setPassword(Image b) {
    b = _badge;
  }


  bool get getIsClaimed {
    return _isClaimed;
  }

  set setIsClaimed(bool i) {
    i = _isClaimed;
  }
}
