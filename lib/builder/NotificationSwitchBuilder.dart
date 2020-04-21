import 'package:flutter/material.dart';

class NotificationSwitchBuilder extends StatefulWidget {
  bool isSwitched = true;

  createState() => NotificationSwitchBuilderState();
}

class NotificationSwitchBuilderState extends State<NotificationSwitchBuilder> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Text('Notification switch'),
            Switch(
              value: widget.isSwitched,
              onChanged: (value) {
                setState(() {
                  widget.isSwitched = value;
                });
              },
              activeTrackColor: Colors.lightBlueAccent,
              activeColor: Colors.blueAccent,
            ),
          ])),
    );
  }
}
