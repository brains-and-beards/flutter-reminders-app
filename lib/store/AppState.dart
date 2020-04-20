import 'package:hello_world/models/Alarm.dart';

class AppState {
  final List<Alarm> alarms;

  AppState({this.alarms});

  AppState copyWith({List<Alarm> alarms}) {
    return AppState(alarms: alarms ?? this.alarms);
  }
}
