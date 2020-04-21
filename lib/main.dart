import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hello_world/actions/actions.dart';
import 'package:hello_world/models/Alarm.dart';
import 'package:hello_world/store/AppState.dart';
import 'package:hello_world/store/store.dart';
import 'package:hello_world/utils/notificationHelper.dart';
import 'package:redux/redux.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'builder/NotificationSwitchBuilder.dart';
import 'models/index.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
NotificationAppLaunchDetails notificationAppLaunchDetails;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final store = await createStore();

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
          home: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              NotificationSwitchBuilder(),
              StoreConnector<AppState, List<Alarm>>(
                converter: (store) => store.state.alarmsState.alarms,
                builder: (context, alarms) {
                  return Text(
                    alarms.length > 0 && alarms[alarms.length - 1] != null
                        ? alarms[alarms.length - 1].time
                        : '',
                    style: Theme.of(context).textTheme.display1,
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: StoreConnector<AppState, VoidCallback>(
          converter: (store) {
            return () => store.dispatch(SetAlarmAction());
          },
          builder: (context, callback) {
            return FloatingActionButton(
              onPressed: callback,
              tooltip: 'hello',
              child: Icon(Icons.add),
            );
          },
        ),
      )),
      store: store,
    );
  }
}
