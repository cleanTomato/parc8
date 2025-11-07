import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parc8/shared/constants/app_constants.dart';
import 'package:parc8/features/water_tracker/state/water_tracker_state.dart';

class SettingsScreen extends StatelessWidget {
  final WaterTrackerState appState;

  const SettingsScreen({
    super.key,
    required this.appState,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: appState.dailyGoal.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Дневная цель',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Объем в мл',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        final newGoal = int.tryParse(controller.text) ?? AppConstants.defaultDailyGoal;
                        appState.updateDailyGoal(newGoal);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Цель обновлена')),
                        );
                      },
                      child: const Text('Сохранить цель'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Навигация',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => context.go('/'),
                      child: const Text('Вернуться на главную'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'О приложении',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text('Трекер водного баланса'),
                    const Text('Версия 1.0.0'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}