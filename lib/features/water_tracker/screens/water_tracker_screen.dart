import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parc8/features/water_tracker/models/water_intake.dart';
import 'package:parc8/features/water_tracker/widgets/intake_list_view.dart';
import 'package:parc8/features/water_tracker/widgets/smart_water_button.dart';
import 'package:parc8/features/water_tracker/widgets/water_level_indicator.dart';
import 'package:parc8/features/water_tracker/widgets/progress_circle.dart';
import 'package:parc8/features/water_tracker/state/water_tracker_state.dart';

class WaterTrackerScreen extends StatelessWidget {
  final WaterTrackerState appState;

  const WaterTrackerScreen({
    super.key,
    required this.appState,
  });

  @override
  Widget build(BuildContext context) {
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
            tooltip: 'Статистика',
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => context.push('/history'),
            tooltip: 'История',
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
                  progress: appState.progress,
                  current: appState.totalIntake,
                  goal: appState.dailyGoal,
                ),
                WaterLevelIndicator(progress: appState.progress),
              ],
            ),
            const SizedBox(height: 20),


            SmartWaterButton(
              currentVolume: appState.totalIntake,
              dailyGoal: appState.dailyGoal,
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
                        label: const Text('Статистика'),
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
                        onPressed: () => context.push('/history'),
                        icon: const Icon(Icons.history),
                        label: const Text('История'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => context.go('/settings'),
                        icon: const Icon(Icons.settings),
                        label: const Text('Настройки'),
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