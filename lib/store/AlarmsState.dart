import 'package:hello_world/models/Alarm.dart';

class AlarmsState {
  final List<Alarm> alarms;

  AlarmsState({this.alarms});

  factory AlarmsState.initial() {
    return new AlarmsState(alarms: []);
  }

  AlarmsState copyWith({List<Alarm> alarms}) {
    return AlarmsState(alarms: alarms ?? this.alarms);
  }
}
