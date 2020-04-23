import 'package:hello_world/models/Alarm.dart';

class AlarmsState {
  final List<Alarm> alarms;

  AlarmsState({this.alarms});

  factory AlarmsState.initial() {
    return new AlarmsState(alarms: []);
  }

  static AlarmsState fromJson(dynamic json) {
    return json != null
        ? AlarmsState(
            alarms: parseList(json),
          )
        : [];
  }

  dynamic toJson() {
    return {'alarms': this.alarms.map((alarm) => alarm.toJson()).toList()};
  }

  AlarmsState copyWith({List<Alarm> alarms}) {
    return AlarmsState(alarms: alarms ?? this.alarms);
  }
}

List<Alarm> parseList(dynamic json) {
  List<Alarm> list = new List<Alarm>();
  for (var i = 0; i < json["alarms"].length; i++) {
    list.add(Alarm.fromJson(json["alarms"][i]));
  }
  return list;
}
