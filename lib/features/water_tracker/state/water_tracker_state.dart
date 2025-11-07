import 'package:flutter/foundation.dart';
import 'package:parc8/features/water_tracker/models/water_intake.dart';

class WaterTrackerState extends ChangeNotifier {
  final List<WaterIntake> _intakes = [];

  List<WaterIntake> get intakes => List.unmodifiable(_intakes);

  void addIntake(WaterIntake intake) {
    _intakes.add(intake);
    notifyListeners();
  }

  void deleteIntake(String id) {
    _intakes.removeWhere((intake) => intake.id == id);
    notifyListeners();
  }

  int get totalIntake {
    return _intakes.fold(0, (sum, intake) => sum + intake.effectiveVolume);
  }

  double getProgress(int dailyGoal) {
    return dailyGoal > 0 ? totalIntake / dailyGoal : 0.0;
  }
}