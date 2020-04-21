import 'package:flutter/material.dart';
import 'package:hello_world/store/AlarmsState.dart';

@immutable
class AppState {
  final AlarmsState alarmsState;

  AppState({@required this.alarmsState});

  factory AppState.initial() {
    return AppState(
      alarmsState: AlarmsState.initial(),
    );
  }

  AppState copyWith({AlarmsState alarmsState}) {
    return AppState(alarmsState: alarmsState ?? this.alarmsState);
  }
}
