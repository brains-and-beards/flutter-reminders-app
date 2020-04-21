import 'package:meta/meta.dart';

class AlarmNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  AlarmNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}
