import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hello_world/actions/actions.dart';
import 'package:hello_world/main.dart';
import 'package:hello_world/models/Alarm.dart';
import 'package:hello_world/store/store.dart';
import 'package:hello_world/utils/notificationHelper.dart';

final playMusic = 'Play music';
final lookAfterPlants = 'Look after plants';
final walk = '5 min walk';
final drinkingWater = 'Drink some water';
final custom = 'Custom time';

final remindersIcons = {
  playMusic: Icons.audiotrack,
  lookAfterPlants: Icons.local_florist,
  walk: Icons.directions_walk,
  drinkingWater: Icons.local_drink,
  custom: Icons.image,
};

class ReminderAlertBuilder extends StatefulWidget {
  ReminderAlertBuilder({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ReminderAlertBuilderState createState() => _ReminderAlertBuilderState();
}

class _ReminderAlertBuilderState extends State<ReminderAlertBuilder> {
  bool playMusicReminder = false;
  bool lookAfterPlantsReminder = false;
  bool walkFor5minReminder = false;
  bool drinkSomeWaterReminder = false;
  bool customReminder = false;

  TimeOfDay customNotificationTime;

  @override
  Widget build(BuildContext context) {
    _prepareState();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text('Manage reminder'),
            color: Colors.blue,
            onPressed: _showMaterialDialog,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }

  _showMaterialDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              contentPadding: EdgeInsets.all(0.0),
              backgroundColor: Colors.white,
              content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 10,
                    height: MediaQuery.of(context).size.height - 80,
                    padding: EdgeInsets.all(20),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                            padding: new EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Remind me every day',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.w500),
                            )),
                        Card(
                          margin: new EdgeInsets.only(left: 0, right: 0),
                          child: CheckboxListTile(
                              title: Row(
                                children: <Widget>[
                                  Icon(
                                    remindersIcons[playMusic],
                                    color: Colors.black,
                                    size: 30.0,
                                  ),
                                  Padding(
                                    padding: new EdgeInsets.only(left: 10),
                                    child: Text(
                                      playMusic,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  )
                                ],
                              ),
                              value: playMusicReminder,
                              onChanged: (value) {
                                setState(() {
                                  playMusicReminder = value;
                                });
                                _configurePlayMusic(value);
                              }),
                        ),
                        Padding(
                            padding: new EdgeInsets.only(bottom: 10, top: 10),
                            child: Text(
                              'Reminde me every week',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.w500),
                            )),
                        Card(
                            margin:
                                new EdgeInsets.only(left: 0, right: 0, top: 5),
                            child: CheckboxListTile(
                                value: lookAfterPlantsReminder,
                                onChanged: (value) {
                                  setState(() {
                                    lookAfterPlantsReminder = value;
                                  });
                                  _configureLookAfterPlants(value);
                                },
                                title: Row(children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        remindersIcons[lookAfterPlants],
                                        color: Colors.green,
                                        size: 30.0,
                                      ),
                                      Padding(
                                          padding:
                                              new EdgeInsets.only(left: 10),
                                          child: Text(
                                            lookAfterPlants,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal),
                                          ))
                                    ],
                                  ),
                                ]))),
                        Padding(
                            padding: new EdgeInsets.only(bottom: 10, top: 10),
                            child: Text(
                              'Remind me every hour',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.w500),
                            )),
                        Card(
                            margin: new EdgeInsets.only(left: 0, right: 0),
                            child: CheckboxListTile(
                                value: walkFor5minReminder,
                                onChanged: (value) {
                                  setState(() {
                                    walkFor5minReminder = value;
                                  });
                                  _configure5minWalk(value);
                                },
                                title: Row(children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        remindersIcons[walk],
                                        color: Colors.red,
                                        size: 30.0,
                                      ),
                                      Padding(
                                          padding:
                                              new EdgeInsets.only(left: 10),
                                          child: Text(
                                            walk,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal),
                                          ))
                                    ],
                                  )
                                ]))),
                        Card(
                            margin:
                                new EdgeInsets.only(left: 0, right: 0, top: 10),
                            child: CheckboxListTile(
                                value: drinkSomeWaterReminder,
                                onChanged: (value) {
                                  setState(() {
                                    drinkSomeWaterReminder = value;
                                  });
                                  _configureDrinkSomeWater(value);
                                },
                                title: Row(children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        remindersIcons[drinkingWater],
                                        color: Colors.blue,
                                        size: 30.0,
                                      ),
                                      Padding(
                                          padding:
                                              new EdgeInsets.only(left: 10),
                                          child: Text(
                                            drinkingWater,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal),
                                          ))
                                    ],
                                  )
                                ]))),
                        Padding(
                            padding: new EdgeInsets.only(bottom: 10, top: 10),
                            child: Text(
                              'Custom',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.w500),
                            )),
                        Card(
                            margin: new EdgeInsets.only(
                                left: 0, right: 0, bottom: 10),
                            child: CheckboxListTile(
                                value: customReminder,
                                onChanged: (value) {
                                  setState(() {
                                    customReminder = value;
                                  });
                                  _configureCustomReminder(value);
                                },
                                title: Row(children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        remindersIcons[custom],
                                        color: Colors.blue,
                                        size: 30.0,
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Padding(
                                              padding:
                                                  new EdgeInsets.only(left: 10),
                                              child: Text(
                                                custom,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )),
                                          SizedBox(
                                            child: Padding(
                                                padding: new EdgeInsets.only(
                                                    top: 10, bottom: 10),
                                                child: RaisedButton(
                                                  color: Colors.blue,
                                                  child: Text(
                                                    'SET TIME',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.white),
                                                  ),
                                                  onPressed: () {
                                                    _showTimeDialog();
                                                  },
                                                )),
                                            width: 90,
                                            height: 40,
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ]))),
                        Padding(
                          padding: new EdgeInsets.only(top: 20, bottom: 10),
                          child: RaisedButton(
                              color: Colors.blue,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "SAVE",
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                      ],
                    ),
                  ),
                );
              }));
        });
  }

  _showTimeDialog() async {
    TimeOfDay selectedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    setState(() {
      customNotificationTime = selectedTime;
    });
  }

  _prepareState() {
    List<Alarm> list = getStore().state.alarmsState.alarms;
    for (var i = 0; i < list.length; i++) {
      if (list[i].name == playMusic) {
        playMusicReminder = true;
      } else if (list[i].name == lookAfterPlants) {
        lookAfterPlantsReminder = true;
      } else if (list[i].name == walk) {
        walkFor5minReminder = true;
      } else if (list[i].name == drinkingWater) {
        drinkSomeWaterReminder = true;
      } else if (list[i].name == custom) {
        customReminder = true;
      }
    }
  }

  void _configurePlayMusic(bool value) {
    if (value) {
      getStore().dispatch(SetAlarmAction(
          time: new DateTime.now().toIso8601String(),
          name: playMusic,
          repeat: RepeatInterval.Daily));

      scheduleNotificationPeriodically(flutterLocalNotificationsPlugin, '0',
          playMusic, RepeatInterval.Daily);
    } else {
      turnOffNotificationById(flutterLocalNotificationsPlugin, 0);
      getStore().dispatch(RemoveAlarmAction(playMusic));
    }
  }

  void _configureLookAfterPlants(bool value) {
    if (value) {
      getStore().dispatch(SetAlarmAction(
          time: new DateTime.now().toIso8601String(),
          name: lookAfterPlants,
          repeat: RepeatInterval.Daily));
      scheduleNotificationPeriodically(flutterLocalNotificationsPlugin, '1',
          lookAfterPlants, RepeatInterval.Weekly);
    } else {
      getStore().dispatch(RemoveAlarmAction(lookAfterPlants));
      turnOffNotificationById(flutterLocalNotificationsPlugin, 1);
    }
  }

  void _configure5minWalk(bool value) {
    if (value) {
      getStore().dispatch(SetAlarmAction(
          time: new DateTime.now().toIso8601String(),
          name: walk,
          repeat: RepeatInterval.Hourly));
      scheduleNotificationPeriodically(
          flutterLocalNotificationsPlugin, '2', walk, RepeatInterval.Hourly);
    } else {
      getStore().dispatch(RemoveAlarmAction(walk));
      turnOffNotificationById(flutterLocalNotificationsPlugin, 2);
    }
  }

  void _configureDrinkSomeWater(bool value) {
    if (value) {
      getStore().dispatch(SetAlarmAction(
          time: new DateTime.now().toIso8601String(),
          name: drinkingWater,
          repeat: RepeatInterval.Hourly));
      scheduleNotificationPeriodically(flutterLocalNotificationsPlugin, '3',
          drinkingWater, RepeatInterval.Hourly);
    } else {
      getStore().dispatch(RemoveAlarmAction(drinkingWater));
      turnOffNotificationById(flutterLocalNotificationsPlugin, 3);
    }
  }

  void _configureCustomReminder(bool value) {
    if (value) {
      var now = new DateTime.now();

      getStore().dispatch(SetAlarmAction(
          time: now.toIso8601String(),
          name: custom,
          repeat: RepeatInterval.Daily));

      var notificationTime = new DateTime(now.year, now.month, now.day,
          customNotificationTime.hour, customNotificationTime.minute);

      scheduleNotification(
          flutterLocalNotificationsPlugin, '4', custom, notificationTime);
    } else {
      getStore().dispatch(RemoveAlarmAction(custom));
      turnOffNotificationById(flutterLocalNotificationsPlugin, 4);
    }
  }
}
