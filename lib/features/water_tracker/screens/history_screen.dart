import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parc8/features/water_tracker/models/water_intake.dart';
import 'package:parc8/features/water_tracker/widgets/intake_list_view.dart';
import 'package:parc8/features/water_tracker/state/water_tracker_state.dart';

class HistoryScreen extends StatelessWidget {
  final WaterTrackerState appState;

  const HistoryScreen({
    super.key,
    required this.appState,
  });

  @override
  Widget build(BuildContext context) {
    final sortedIntakes = List<WaterIntake>.from(appState.intakes)
      ..sort((a, b) => b.time.compareTo(a.time));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('История записей'),
      ),
      body: IntakeListView(
        intakes: sortedIntakes,
        onDelete: appState.deleteIntake,
      ),
    );
  }
}