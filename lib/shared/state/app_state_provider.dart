import 'package:flutter/material.dart';
import 'package:parc8/features/water_tracker/state/water_tracker_state.dart';

class AppStateProvider extends InheritedWidget {
  final WaterTrackerState appState;

  const AppStateProvider({
    super.key,
    required super.child,
    required this.appState,
  });

  static AppStateProvider of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<AppStateProvider>();
    assert(result != null, 'No AppStateProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AppStateProvider oldWidget) {
    return oldWidget.appState != appState;
  }
}