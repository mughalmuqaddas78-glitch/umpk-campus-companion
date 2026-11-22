// app_constants.dart
// Fixed values used across the app. Keeping them in one file avoids
// "magic numbers" scattered around and makes changes easy later.

import 'package:flutter/material.dart';

/// A holder for app-wide constants.
/// The private constructor stops anyone from creating an instance,
/// because we only ever use the static values.
class AppConstants {
  AppConstants._();

  /// The name shown in the app bar and used as the app title.
  static const String appName = 'UMPK Campus Companion';

  /// The single colour that Material 3 uses to generate the whole palette.
  static const Color seedColor = Color(0xFF2E7D32); // a calm green

  /// Standard spacing values (in logical pixels) for consistent layouts.
  static const double spacingSmall = 8;
  static const double spacingMedium = 16;
  static const double spacingLarge = 24;

  /// Standard corner radius for cards, buttons and inputs.
  static const double borderRadius = 16;
}
