import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parc8/features/water_tracker/widgets/intake_list_view.dart';
import 'package:parc8/features/water_tracker/widgets/smart_water_button.dart';
import 'package:parc8/features/water_tracker/widgets/water_level_indicator.dart';
import 'package:parc8/features/water_tracker/widgets/progress_circle.dart';
import 'package:parc8/shared/state/app_state_provider.dart';
import 'package:parc8/shared/di/service_locator.dart';
import 'package:parc8/shared/services/settings_service.dart';

class WaterTrackerScreen extends StatelessWidget {
  const WaterTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context).appState;
    final settingsService = serviceLocator<SettingsService>();
    final progress = appState.getProgress(settingsService.dailyGoal);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Водный баланс'),
        actions: [
          IconButton(
            icon: const Icon(Icons.photo_library),
            onPressed: () => context.push('/gallery'),
            tooltip: 'Галерея напитков',
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () => context.push('/statistics'),
            tooltip: 'Статистика (Inherited)',
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart_outlined),
            onPressed: () => context.push('/statistics-getit'),
            tooltip: 'Статистика (GetIt)',
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => context.push('/history'),
            tooltip: 'История',
          ),
          IconButton(
            icon: Icon(settingsService.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => settingsService.toggleTheme(),
            tooltip: 'Переключить тему',
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.go('/settings'),
            tooltip: 'Настройки',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProgressCircle(
                  progress: progress,
                  current: appState.totalIntake,
                  goal: settingsService.dailyGoal,
                ),
                WaterLevelIndicator(progress: progress),
              ],
            ),
            const SizedBox(height: 20),
            SmartWaterButton(
              currentVolume: appState.totalIntake,
              dailyGoal: settingsService.dailyGoal,
              onPressed: () => context.push('/add'),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => context.push('/gallery'),
                        icon: const Icon(Icons.photo_library),
                        label: const Text('Галерея'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => context.push('/statistics'),
                        icon: const Icon(Icons.bar_chart),
                        label: const Text('Статистика (Inherited)'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => context.push('/statistics-getit'),
                        icon: const Icon(Icons.bar_chart_outlined),
                        label: const Text('Статистика (GetIt)'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => context.push('/history'),
                        icon: const Icon(Icons.history),
                        label: const Text('История'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: IntakeListView(
                intakes: appState.intakes,
                onDelete: appState.deleteIntake,
              ),
            ),
          ],
        ),
      ),
    );
  }
}