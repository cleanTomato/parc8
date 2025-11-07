import 'package:flutter/foundation.dart';

class SettingsService extends ChangeNotifier {
  int _dailyGoal = 2000;
  bool _isDarkMode = false;

  int get dailyGoal => _dailyGoal;
  bool get isDarkMode => _isDarkMode;

  void updateDailyGoal(int goal) {
    _dailyGoal = goal;
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}