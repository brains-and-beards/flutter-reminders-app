import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';

class Alarm {
  final String time;
  final RepeatInterval repeat;
  final String name;

  const Alarm({
    @required this.time,
    @required this.repeat,
    @required this.name,
  });

  static Alarm fromJson(dynamic json) {
    return json != null
        ? new Alarm(
            time: json["time"],
            repeat: RepeatInterval.Hourly,
            name: json["name"])
        : null;
  }

  dynamic toJson() {
    return {
      "time": time,
      "repeat": 'Hourly',
      "name": name,
    };
  }
}
