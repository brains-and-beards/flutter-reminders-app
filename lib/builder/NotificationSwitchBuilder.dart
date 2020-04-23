import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hello_world/utils/notificationHelper.dart';

class NotificationSwitchBuilder extends StatefulWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  NotificationSwitchBuilder({Key key, this.flutterLocalNotificationsPlugin});

  @override
  _NotificationSwitchBuilderState createState() =>
      _NotificationSwitchBuilderState();
}

class _NotificationSwitchBuilderState extends State<NotificationSwitchBuilder> {
  bool isSwitched = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Switch(
              value: isSwitched,
              onChanged: (value) {
                if (!value) {
                  turnOffNotification(widget.flutterLocalNotificationsPlugin);
                }
                setState(() {
                  isSwitched = value;
                });
              },
              activeTrackColor: Colors.lightBlueAccent,
              activeColor: Colors.blueAccent,
            ),
            Text(
              'CANCEL ALL',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ])),
    );
  }
}
