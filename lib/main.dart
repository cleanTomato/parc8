import 'package:flutter/material.dart';
import 'package:parc8/app.dart';
import 'package:parc8/shared/di/service_locator.dart';

void main() {
  setupServiceLocator();
  runApp(const App());
}