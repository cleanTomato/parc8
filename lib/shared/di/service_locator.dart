import 'package:get_it/get_it.dart';
import 'package:parc8/shared/services/settings_service.dart';
import 'package:parc8/features/water_tracker/state/water_tracker_state.dart';

final GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton<SettingsService>(() => SettingsService());
  serviceLocator.registerLazySingleton<WaterTrackerState>(() => WaterTrackerState());
}