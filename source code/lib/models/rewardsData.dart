import 'package:focusflow/models/Reward.dart';

/* This is the Rewarddata model.
As I didn't really care, I made both tasks and rewards as fabrics. I recommend creating a User 
class that will have both of those fabrics as unique objects inside them. It is an old and boring design.*/

class Rewardsdata {
  static final List<Reward> _tasksForUser = [];
  static List<Reward> get getTasksList => _tasksForUser;

  static void createRewards() {
    //_tasksForUser.add(Reward(_name, _description, _badge, _completion, _country, _isClaimed))
  }
}
