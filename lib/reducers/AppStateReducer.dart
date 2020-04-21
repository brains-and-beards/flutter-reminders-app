import 'package:hello_world/actions/actions.dart';
import 'package:hello_world/models/Alarm.dart';
import 'package:hello_world/store/AlarmsState.dart';
import 'package:hello_world/store/AppState.dart';
import 'package:redux/redux.dart';

AppState appReducer(AppState state, dynamic action) => AppState(
      alarmsState: alarmsReducer(state.alarmsState, action),
    );

final alarmsReducer = combineReducers<AlarmsState>([
  TypedReducer<AlarmsState, SetAlarmAction>(_setAlarmAction),
  TypedReducer<AlarmsState, ClearAlarmAction>(_clearAlarmAction),
]);

AlarmsState _setAlarmAction(AlarmsState state, SetAlarmAction action) {
  var alarmsList = state.alarms;
  if (alarmsList != null) {
    alarmsList.add(new Alarm(
        notificationSent: false,
        repeat: true,
        time: new DateTime.now().toIso8601String()));
  }
  return state.copyWith(alarms: alarmsList);
}

AlarmsState _clearAlarmAction(AlarmsState state, ClearAlarmAction action) =>
    state.copyWith(alarms: []);
