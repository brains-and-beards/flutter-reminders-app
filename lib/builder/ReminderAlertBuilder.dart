import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hello_world/actions/actions.dart';
import 'package:hello_world/main.dart';
import 'package:hello_world/models/Alarm.dart';
import 'package:hello_world/store/store.dart';
import 'package:hello_world/utils/notificationHelper.dart';

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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text('Manage reminder'),
            onPressed: _showMaterialDialog,
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
                              'Reminde me every day at 5pm',
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
                                    Icons.audiotrack,
                                    color: Colors.black,
                                    size: 30.0,
                                  ),
                                  Padding(
                                    padding: new EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Play music',
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
                                        Icons.local_florist,
                                        color: Colors.green,
                                        size: 30.0,
                                      ),
                                      Padding(
                                          padding:
                                              new EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Look after plants',
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
                              'Remind me every hour (8am-5pm)',
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
                                        Icons.directions_walk,
                                        color: Colors.red,
                                        size: 30.0,
                                      ),
                                      Padding(
                                          padding:
                                              new EdgeInsets.only(left: 10),
                                          child: Text(
                                            '5 min walk',
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
                              'Remind me every 30min (7am-7pm)',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.w500),
                            )),
                        Card(
                            margin: new EdgeInsets.only(left: 0, right: 0),
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
                                        Icons.local_drink,
                                        color: Colors.blue,
                                        size: 30.0,
                                      ),
                                      Padding(
                                          padding:
                                              new EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Drink some water',
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
                                value: true,
                                onChanged: (newValue) => {},
                                title: Row(children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.image,
                                        color: Colors.blue,
                                        size: 30.0,
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Padding(
                                              padding:
                                                  new EdgeInsets.only(left: 10),
                                              child: Text(
                                                'Custom time',
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
                        RaisedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "SAVE",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                        )
                      ],
                    ),
                  ),
                );
              }));
        });
  }

  _showTimeDialog() {
    Future<TimeOfDay> selectedTime = showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
  }

  void _configurePlayMusic(bool value) {
    if (value) {
      getStore().dispatch(SetAlarmAction(
          time: new DateTime.now().toIso8601String(),
          name: 'Play Music',
          notificationSent: true,
          repeat: RepeatAction.EveryDay));
    } else {
      turnOffNotificationById(flutterLocalNotificationsPlugin, 0);
      getStore().dispatch(RemoveAlarmAction('Play Music'));
    }
  }

  void _configureLookAfterPlants(bool value) {
    if (value) {
      getStore().dispatch(SetAlarmAction(
          time: new DateTime.now().toIso8601String(),
          name: 'Look After Plants',
          notificationSent: true,
          repeat: RepeatAction.EveryDay));
    } else {
      getStore().dispatch(RemoveAlarmAction('Look After Plants'));
    }
  }

  void _configure5minWalk(bool value) {
    if (value) {
      getStore().dispatch(SetAlarmAction(
          time: new DateTime.now().toIso8601String(),
          name: '5 minutes walk',
          notificationSent: true,
          repeat: RepeatAction.WorkingHours));
    } else {
      getStore().dispatch(RemoveAlarmAction('5 minutes walk'));
    }
  }

  void _configureDrinkSomeWater(bool value) {
    if (value) {
      getStore().dispatch(SetAlarmAction(
          time: new DateTime.now().toIso8601String(),
          name: 'Drink some water',
          notificationSent: true,
          repeat: RepeatAction.WorkingHours));
    } else {
      getStore().dispatch(RemoveAlarmAction('Drink some water'));
    }
  }
}
