import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parc8/shared/di/service_locator.dart';
import 'package:parc8/shared/services/settings_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsService = serviceLocator<SettingsService>();
    final controller = TextEditingController(text: settingsService.dailyGoal.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
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
                        final newGoal = int.tryParse(controller.text) ?? 2000;
                        settingsService.updateDailyGoal(newGoal);
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
              child: SwitchListTile(
                title: const Text('Темная тема'),
                value: settingsService.isDarkMode,
                onChanged: (value) => settingsService.toggleTheme(),
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
                    const SizedBox(height: 10),
                    const Text(
                      'Архитектура:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text('- Inherited Widget для управления данными о воде'),
                    const Text('- GetIt DI контейнер для настроек и темы'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('Вернуться на главную'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}