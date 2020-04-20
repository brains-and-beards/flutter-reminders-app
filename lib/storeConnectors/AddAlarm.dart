// import 'package:flutter/material.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:hello_world/actions/actions.dart';
// import 'package:hello_world/models/Alarm.dart';
// import 'package:hello_world/store/AppState.dart';

// class AddAlarmButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Alarm sampleAlarm = Alarm(
//         notificationSent: false,
//         repeat: true,
//         time: new DateTime.now().toIso8601String());

//     return SizedBox(
//           height: 100,
//           width: 100,
//           child: StoreConnector<AppState, Function(Alarm)>(
//               converter: (store) =>
//                   (alarm) => store.dispatch(SetAlarmAction(alarm)),
//               builder: (context, callback) {
//                 return RaisedButton(
//                   onPressed: () => callback(sampleAlarm),
//                   child: Text('Add alarm'),
//                 );
//               }
//               )
//               );
// }}
