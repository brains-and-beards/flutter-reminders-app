import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SetReminderAction {
  final String time;
  final RepeatInterval repeat;
  final String name;

  SetReminderAction({this.time, this.repeat, this.name});
}

class RemoveReminderAction {
  final String name;

  RemoveReminderAction(this.name);
}

class ClearReminderAction {}
