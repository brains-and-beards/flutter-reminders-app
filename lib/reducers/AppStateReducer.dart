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
  TypedReducer<AlarmsState, RemoveAlarmAction>(_removeAlarmAction),
]);

AlarmsState _setAlarmAction(AlarmsState state, SetAlarmAction action) {
  var alarmsList = state.alarms;
  if (alarmsList != null) {
    alarmsList.add(
        new Alarm(repeat: action.repeat, name: action.name, time: action.time));
  }
  return state.copyWith(alarms: alarmsList);
}

AlarmsState _clearAlarmAction(AlarmsState state, ClearAlarmAction action) =>
    state.copyWith(alarms: []);

AlarmsState _removeAlarmAction(AlarmsState state, RemoveAlarmAction action) {
  var alarmsList = state.alarms;
  alarmsList.removeWhere((alarm) => alarm.name == action.name);
  return state.copyWith(alarms: alarmsList);
}
