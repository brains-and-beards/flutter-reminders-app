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

  dynamic toJson() {
    return {'alarmsState': this.alarmsState.toJson()};
  }

  static AppState fromJson(dynamic json) {
    return json != null
        ? AppState(alarmsState: AlarmsState.fromJson(json["alarmsState"]))
        : {};
  }

  AppState copyWith({AlarmsState alarmsState}) {
    return AppState(alarmsState: alarmsState ?? this.alarmsState);
  }
}
