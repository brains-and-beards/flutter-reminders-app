import 'package:hello_world/models/index.dart';

class RemindersState {
  final List<Reminder> reminders;

  RemindersState({this.reminders});

  factory RemindersState.initial() {
    return new RemindersState(reminders: []);
  }

  static RemindersState fromJson(dynamic json) {
    return json != null
        ? RemindersState(
            reminders: parseList(json),
          )
        : [];
  }

  dynamic toJson() {
    return {
      'reminders': this.reminders.map((reminder) => reminder.toJson()).toList()
    };
  }

  RemindersState copyWith({List<Reminder> reminders}) {
    return RemindersState(reminders: reminders ?? this.reminders);
  }
}

List<Reminder> parseList(dynamic json) {
  List<Reminder> list = new List<Reminder>();
  json["reminders"].forEach((item) => list.add(Reminder.fromJson(item)));
  return list;
}
