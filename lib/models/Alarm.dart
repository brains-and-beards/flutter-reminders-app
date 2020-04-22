import 'package:meta/meta.dart';

enum RepeatAction { WorkingHours, Every30minutes, Once, EveryDay }

class Alarm {
  final String time;
  final RepeatAction repeat;
  final bool notificationSent;
  final String name;

  const Alarm({
    @required this.time,
    @required this.repeat,
    @required this.notificationSent,
    @required this.name,
  });
}
