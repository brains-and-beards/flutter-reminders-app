import 'package:hello_world/reducers/AppStateReducer.dart';
import 'package:hello_world/store/AppState.dart';
import 'package:redux/redux.dart';

Store<AppState> store;

Future<Store<AppState>> createStore() async {
  return Store(
    appReducer,
    initialState: new AppState.initial(),
    middleware: [],
  );
}

Future<void> initStore() async {
  store = await createStore();
}

Store<AppState> getStore() {
  return store;
}
