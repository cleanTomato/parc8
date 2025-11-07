import 'package:parc8/features/water_tracker/models/water_intake.dart';
import 'package:parc8/shared/constants/app_constants.dart';

class WaterTrackerState {
  final List<WaterIntake> _intakes = [];
  int _dailyGoal = AppConstants.defaultDailyGoal;

  List<WaterIntake> get intakes => List.unmodifiable(_intakes);
  int get dailyGoal => _dailyGoal;

  void addIntake(WaterIntake intake) {
    _intakes.add(intake);
  }

  void deleteIntake(String id) {
    _intakes.removeWhere((intake) => intake.id == id);
  }

  void updateDailyGoal(int goal) {
    _dailyGoal = goal;
  }

  int get totalIntake {
    return _intakes.fold(0, (sum, intake) => sum + intake.effectiveVolume);
  }

  double get progress {
    return _dailyGoal > 0 ? totalIntake / _dailyGoal : 0.0;
  }
}