import 'package:hello_world/models/index.dart';

class SetAlarmAction {
  final String time;
  final RepeatAction repeat;
  final bool notificationSent;
  final String name;

  SetAlarmAction({this.time, this.repeat, this.notificationSent, this.name});
}

class RemoveAlarmAction {
  final String name;

  RemoveAlarmAction(this.name);
}

class ClearAlarmAction {}
