import 'dart:io';

import 'package:hello_world/reducers/AppStateReducer.dart';
import 'package:hello_world/store/AppState.dart';
import 'package:redux/redux.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:path_provider/path_provider.dart';

Store<AppState> store;
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/state.json');
}

Future<Store<AppState>> createStore() async {
  final persistor = Persistor<AppState>(
    storage: FileStorage(await _localFile),
    serializer: JsonSerializer<AppState>(AppState.fromJson),
    debug: true,
  );

  var initialState;
  try {
    initialState = await persistor.load();
  } catch (e) {
    initialState = null;
  }

  return Store(
    appReducer,
    initialState: initialState ?? new AppState.initial(),
    middleware: [persistor.createMiddleware()],
  );
}

Future<void> initStore() async {
  store = await createStore();
}

Store<AppState> getStore() {
  return store;
}
