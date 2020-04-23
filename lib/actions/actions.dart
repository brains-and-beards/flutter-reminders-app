import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SetAlarmAction {
  final String time;
  final RepeatInterval repeat;
  final String name;

  SetAlarmAction({this.time, this.repeat, this.name});
}

class RemoveAlarmAction {
  final String name;

  RemoveAlarmAction(this.name);
}

class ClearAlarmAction {}
