import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parc8/features/water_tracker/screens/water_tracker_screen.dart';
import 'package:parc8/features/water_tracker/screens/add_intake_screen.dart';
import 'package:parc8/features/water_tracker/screens/statistics_screen.dart';
import 'package:parc8/features/water_tracker/screens/statistics_screen_getit.dart';
import 'package:parc8/features/water_tracker/screens/history_screen.dart';
import 'package:parc8/features/water_tracker/screens/settings_screen.dart';
import 'package:parc8/features/water_tracker/screens/network_images_screen.dart';
import 'package:parc8/features/water_tracker/state/water_tracker_state.dart';
import 'package:parc8/shared/state/app_state_provider.dart';
import 'package:parc8/shared/di/service_locator.dart';
import 'package:parc8/shared/services/settings_service.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final WaterTrackerState _appState = WaterTrackerState();
  late final SettingsService _settingsService;

  @override
  void initState() {
    super.initState();
    _settingsService = serviceLocator<SettingsService>();
    _settingsService.addListener(_onSettingsChanged);
  }

  void _onSettingsChanged() {
    setState(() {
    });
  }

  @override
  void dispose() {
    _settingsService.removeListener(_onSettingsChanged);
    super.dispose();
  }

  late final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: 'home',
        builder: (BuildContext context, GoRouterState state) {
          return const WaterTrackerScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'add',
            name: 'add',
            builder: (BuildContext context, GoRouterState state) {
              return const AddIntakeScreen();
            },
          ),
          GoRoute(
            path: 'statistics',
            name: 'statistics',
            builder: (BuildContext context, GoRouterState state) {
              return const StatisticsScreen();
            },
          ),
          GoRoute(
            path: 'statistics-getit',
            name: 'statistics-getit',
            builder: (BuildContext context, GoRouterState state) {
              return const StatisticsScreenGetIt();
            },
          ),
          GoRoute(
            path: 'history',
            name: 'history',
            builder: (BuildContext context, GoRouterState state) {
              return const HistoryScreen();
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
          return const SettingsScreen();
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return AppStateProvider(
      appState: _appState,
      child: MaterialApp.router(
        title: 'Трекер водного баланса',
        theme: _settingsService.isDarkMode
            ? ThemeData.dark()
            : ThemeData.light(),
        routerConfig: _router,
      ),
    );
  }
}