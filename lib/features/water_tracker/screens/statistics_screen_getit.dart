import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parc8/features/water_tracker/state/water_tracker_state.dart';
import 'package:parc8/shared/constants/drink_types.dart';
import 'package:parc8/shared/di/service_locator.dart';
import 'package:parc8/shared/services/settings_service.dart';

class StatisticsScreenGetIt extends StatelessWidget {
  const StatisticsScreenGetIt({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = serviceLocator<WaterTrackerState>();
    final settingsService = serviceLocator<SettingsService>();
    final progress = appState.getProgress(settingsService.dailyGoal);

    final drinkStats = <String, int>{};
    for (final intake in appState.intakes) {
      drinkStats[intake.drinkType] = (drinkStats[intake.drinkType] ?? 0) + intake.volume;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Статистика (GetIt)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Общая статистика',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('Выпито всего: ${appState.totalIntake} мл'),
                    Text('Дневная цель: ${settingsService.dailyGoal} мл'),
                    Text('Прогресс: ${(progress * 100).toStringAsFixed(1)}%'),
                    const SizedBox(height: 10),
                    const Text(
                      'Используется: GetIt DI контейнер для всего',
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Статистика по напиткам:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: drinkStats.entries.map((entry) {
                  final drink = DrinkTypes.allTypes.firstWhere(
                        (d) => d.id == entry.key,
                    orElse: () => DrinkTypes.allTypes.first,
                  );
                  return ListTile(
                    leading: Icon(drink.icon, color: drink.color),
                    title: Text(drink.name),
                    trailing: Text('${entry.value} мл'),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}