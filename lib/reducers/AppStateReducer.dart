import 'package:hello_world/actions/actions.dart';
import 'package:hello_world/models/Alarm.dart';
import 'package:hello_world/store/AppState.dart';
import 'package:redux/redux.dart';

AppState appReducer(AppState state, dynamic action) => AppState(
      alarms: alarmsReducer(state.alarms, action),
    );

final alarmsReducer = combineReducers<List<Alarm>>([
  TypedReducer<List<Alarm>, SetAlarmAction>(_setAlarmAction),
  TypedReducer<List<Alarm>, ClearAlarmAction>(_clearAlarmAction),
]);

List<Alarm> _setAlarmAction(List<Alarm> list, SetAlarmAction action) {
  if (list != null) {
    list.add(new Alarm(
        notificationSent: false,
        repeat: true,
        time: new DateTime.now().toIso8601String()));
  }
  return list;
}

List<Alarm> _clearAlarmAction(_, __) => [];
