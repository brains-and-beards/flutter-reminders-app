import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hello_world/models/Alarm.dart';
import 'package:hello_world/store/AppState.dart';
import 'package:hello_world/store/store.dart';
import 'package:hello_world/utils/notificationHelper.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'builder/NotificationSwitchBuilder.dart';
import 'builder/ReminderAlertBuilder.dart';
import 'models/index.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
NotificationAppLaunchDetails notificationAppLaunchDetails;

final df = new DateFormat('dd-MM-yyyy hh:mm a');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initStore();
  final store = getStore();
  notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  await initNotifications(flutterLocalNotificationsPlugin);
  requestIOSPermissions(flutterLocalNotificationsPlugin);

  runApp(LunchingApp(store));
}

class LunchingApp extends StatelessWidget {
  final Store<AppState> store;
  LunchingApp(this.store);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      child: MaterialApp(
          title: 'REMINDERS',
          home: Scaffold(
            appBar: AppBar(
              title: Text('Reminders App'),
            ),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: ReminderAlertBuilder()),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: NotificationSwitchBuilder(
                            flutterLocalNotificationsPlugin:
                                flutterLocalNotificationsPlugin,
                            key: new Key('value'),
                          )),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Reminders list",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                              width: 2,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: SizedBox(
                            child: StoreConnector<AppState, List<Alarm>>(
                                converter: (store) =>
                                    store.state.alarmsState.alarms,
                                builder: (context, alarms) {
                                  return ListView.separated(
                                      separatorBuilder: (context, index) {
                                        return Divider();
                                      },
                                      itemCount: alarms.length,
                                      itemBuilder: (context, index) {
                                        final item = alarms[index];
                                        return ListTile(
                                            title: Row(
                                              children: <Widget>[
                                                Icon(
                                                  remindersIcons[item.name],
                                                  color: Colors.black,
                                                  size: 30.0,
                                                ),
                                                Text(item.name)
                                              ],
                                            ),
                                            subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Text(
                                                            "Start time: ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(df.format(
                                                              DateTime.parse(
                                                                  item.time))),
                                                        ],
                                                      )),
                                                  Text(Alarm
                                                      .parseRepeatIntervalToString(
                                                          item.repeat))
                                                ]));
                                      });
                                }),
                            height: 550,
                          ))),
                ],
              ),
            ),
          )),
      store: store,
    );

    ;
  }
}
