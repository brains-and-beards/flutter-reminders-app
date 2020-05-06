import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hello_world/utils/screenTypeHelper.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:hello_world/store/AppState.dart';
import 'package:hello_world/store/store.dart';
import 'package:hello_world/utils/notificationHelper.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'builder/NotificationSwitchBuilder.dart';
import 'builder/ReminderAlertBuilder.dart';
import 'builder/RemindersListViewBuilder.dart';
import 'models/index.dart';

final df = new DateFormat('dd-MM-yyyy hh:mm a');

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
NotificationAppLaunchDetails notificationAppLaunchDetails;
Store<AppState> store;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initStore();
  store = getStore();
  // notificationAppLaunchDetails =
  //     await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  // await initNotifications(flutterLocalNotificationsPlugin);
  // requestIOSPermissions(flutterLocalNotificationsPlugin);

  runApp(LunchingApp(store));
}

class LunchingApp extends StatelessWidget {
  final Store<AppState> store;
  LunchingApp(this.store);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(title: 'REMINDERS', home: new MainWidget());
  }
}

class MainWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  @override
  Widget build(BuildContext context) {
    ResponsiveWidgets.init(
      context,
      height: 1920,
      width: 1080,
      allowFontScaling: true,
    );

    MediaQueryData mediaQuery = MediaQuery.of(context);
    double height = isDesktop(context)
        ? mediaQuery.devicePixelRatio * mediaQuery.size.height * 0.6
        : mediaQuery.devicePixelRatio * mediaQuery.size.height * 0.5;
    double width = isLanscapeNotchDevice(context)
        ? mediaQuery.size.width
        : mediaQuery.devicePixelRatio * mediaQuery.size.width;

    return ResponsiveWidgets.builder(
        allowFontScaling: true,
        child: Scaffold(
            appBar: AppBar(
              title: Text('Reminders App'),
            ),
            body: StoreProvider<AppState>(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsetsResponsive.all(
                                isLanscapeNotchDevice(context) ? 20 : 10),
                            child: ReminderAlertBuilder()),
                        Padding(
                            padding: EdgeInsetsResponsive.all(
                                isLanscapeNotchDevice(context) ? 50 : 10),
                            child: NotificationSwitchBuilder()),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Reminders list",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(50),
                              fontWeight: FontWeight.bold),
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
                            child: SizedBoxResponsive(
                              child: StoreConnector<AppState, List<Reminder>>(
                                  converter: (store) =>
                                      store.state.remindersState.reminders,
                                  builder: (context, reminders) {
                                    return RemindersList(reminders: reminders);
                                  }),
                              width: width,
                              height: height,
                            ))),
                  ],
                ),
              ),
              store: getStore(),
            )));
  }
}
