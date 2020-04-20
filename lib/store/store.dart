import 'package:hello_world/reducers/AppStateReducer.dart';
import 'package:hello_world/store/AppState.dart';
import 'package:redux/redux.dart';

Future<Store<AppState>> createStore() async {
  return Store(
    appReducer,
    initialState: AppState(alarms: []),
    middleware: [],
  );
}
