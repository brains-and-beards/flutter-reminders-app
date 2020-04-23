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
            repeat: parseRepeatIntervalToObject(json["repeat"]),
            name: json["name"])
        : null;
  }

  dynamic toJson() {
    return {
      "time": time,
      "repeat": parseRepeatIntervalToString(repeat),
      "name": name,
    };
  }

  static String parseRepeatIntervalToString(RepeatInterval repeat) {
    if (repeat == RepeatInterval.Daily) {
      return "Daily";
    } else if (repeat == RepeatInterval.EveryMinute) {
      return "EveryMinute";
    } else if (repeat == RepeatInterval.Hourly) {
      return "Hourly";
    } else if (repeat == RepeatInterval.Weekly) {
      return "Weekly";
    }
    return '';
  }

  static RepeatInterval parseRepeatIntervalToObject(String repeat) {
    if (repeat == "Daily") {
      return RepeatInterval.Daily;
    } else if (repeat == "EveryMinute") {
      return RepeatInterval.EveryMinute;
    } else if (repeat == "Hourly") {
      return RepeatInterval.Hourly;
    } else if (repeat == "Weekly") {
      return RepeatInterval.Weekly;
    }
    return RepeatInterval.Weekly;
  }
}
