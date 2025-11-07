import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parc8/features/water_tracker/screens/water_tracker_screen.dart';
import 'package:parc8/features/water_tracker/screens/add_intake_screen.dart';
import 'package:parc8/features/water_tracker/screens/statistics_screen.dart';
import 'package:parc8/features/water_tracker/screens/history_screen.dart';
import 'package:parc8/features/water_tracker/screens/settings_screen.dart';
import 'package:parc8/features/water_tracker/screens/network_images_screen.dart';
import 'package:parc8/features/water_tracker/state/water_tracker_state.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final WaterTrackerState _appState = WaterTrackerState();


  late final GoRouter _router = GoRouter(
    routes: <RouteBase>[

      GoRoute(
        path: '/',
        name: 'home',
        builder: (BuildContext context, GoRouterState state) {
          return WaterTrackerScreen(appState: _appState);
        },
        routes: <RouteBase>[

          GoRoute(
            path: 'add',
            name: 'add',
            builder: (BuildContext context, GoRouterState state) {
              return AddIntakeScreen(appState: _appState);
            },
          ),
          GoRoute(
            path: 'statistics',
            name: 'statistics',
            builder: (BuildContext context, GoRouterState state) {
              return StatisticsScreen(appState: _appState);
            },
          ),
          GoRoute(
            path: 'history',
            name: 'history',
            builder: (BuildContext context, GoRouterState state) {
              return HistoryScreen(appState: _appState);
            },
          ),
          GoRoute(
            path: 'gallery',
            name: 'gallery',
            builder: (BuildContext context, GoRouterState state) {
              return const NetworkImagesScreen();
            },
          ),
        ],
      ),

      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (BuildContext context, GoRouterState state) {
          return SettingsScreen(appState: _appState);
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Трекер водного баланса',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}