// main.dart
// The entry point of the app. Flutter starts running code from main().
// This file only wires things together: it picks the theme and the first screen.

import 'package:flutter/material.dart';

import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'features/home/home_screen.dart';

/// Called by Flutter when the app launches.
/// runApp() puts our root widget on screen.
void main() {
  runApp(const UmpkCampusCompanionApp());
}

/// The root widget of the whole app.
/// It is a StatelessWidget because it holds no data that changes over time.
class UmpkCampusCompanionApp extends StatelessWidget {
  const UmpkCampusCompanionApp({super.key});

  /// Describes the app: its title, themes and starting screen.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false, // hides the red "DEBUG" ribbon

      // Light and dark themes are defined in one place (AppTheme).
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,

      // ThemeMode.system follows the phone's light/dark setting.
      themeMode: ThemeMode.system,

      // The first screen the user sees.
      home: const HomeScreen(),
    );
  }
}
