import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hello_world/models/Alarm.dart';
import 'package:hello_world/store/AppState.dart';
import 'package:hello_world/store/store.dart';
import 'package:hello_world/utils/notificationHelper.dart';
import 'package:redux/redux.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'builder/NotificationSwitchBuilder.dart';
import 'builder/ReminderAlertBuilder.dart';
import 'models/index.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
NotificationAppLaunchDetails notificationAppLaunchDetails;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initStore();
  final store = getStore();
  notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  await initNotifications(flutterLocalNotificationsPlugin);
  requestIOSPermissions(flutterLocalNotificationsPlugin);
  await showNotification(flutterLocalNotificationsPlugin);

  runApp(LunchingApp(store));
}

class LunchingApp extends StatelessWidget {
  final Store<AppState> store;
  LunchingApp(this.store);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      child: MaterialApp(
          title: 'Reminder',
          home: Scaffold(
            appBar: AppBar(
              title: Text('Reminder'),
            ),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      NotificationSwitchBuilder(
                        flutterLocalNotificationsPlugin:
                            flutterLocalNotificationsPlugin,
                        key: new Key('value'),
                      ),
                      ReminderAlertBuilder(),
                      FlatButton(
                          child: Text('send notification'),
                          color: Colors.blue,
                          onPressed: () async => await scheduleNotification(
                              flutterLocalNotificationsPlugin)),
                    ],
                  ),
                  SizedBox(
                    child: StoreConnector<AppState, List<Alarm>>(
                        converter: (store) => store.state.alarmsState.alarms,
                        builder: (context, alarms) {
                          return ListView.builder(
                              itemCount: alarms.length,
                              itemBuilder: (context, index) {
                                final item = alarms[index];
                                return ListTile(
                                  title: Text(item.name),
                                  subtitle: Text(item.time),
                                );
                              });
                        }),
                    height: 300,
                  ),
                ],
              ),
            ),
          )),
      store: store,
    );

    ;
  }
}
