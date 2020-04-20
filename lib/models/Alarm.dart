import 'package:meta/meta.dart';

class Alarm {
  final String time;
  final bool repeat;
  final bool notificationSent;

  const Alarm({
    @required this.time,
    @required this.repeat,
    @required this.notificationSent,
  });
}
