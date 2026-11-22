// app_theme.dart
// Defines how the whole app looks (colours, shapes, text) in light and dark mode.
// Having one theme file means every screen looks consistent automatically.

import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

/// Provides the light and dark ThemeData objects for the app.
/// Private constructor: this class is only a container for static members.
class AppTheme {
  AppTheme._();

  /// The theme used when the phone is in light mode.
  static final ThemeData light = _buildTheme(Brightness.light);

  /// The theme used when the phone is in dark mode.
  static final ThemeData dark = _buildTheme(Brightness.dark);

  /// Builds a full theme for the given brightness.
  /// Both modes share the same code so they stay consistent,
  /// and only the colours differ.
  static ThemeData _buildTheme(Brightness brightness) {
    // Material 3 generates a complete, accessible colour palette
    // from a single seed colour. We ask for light or dark versions.
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: AppConstants.seedColor,
      brightness: brightness,
    );

    // A shared rounded shape reused by the buttons below.
    final RoundedRectangleBorder roundedShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
    );

    // The card shape: rounded corners plus a thin outline.
    // The outline keeps cards clearly visible in dark mode.
    final RoundedRectangleBorder cardShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      side: BorderSide(color: colorScheme.outlineVariant),
    );

    // Start from a Material 3 base theme, then customise parts of it.
    final ThemeData base = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
    );

    return base.copyWith(
      // Slightly more line spacing makes body text easier to read.
      textTheme: base.textTheme.copyWith(
        headlineSmall: base.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w700,
        ),
        titleLarge: base.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: base.textTheme.bodyLarge?.copyWith(height: 1.5),
        bodyMedium: base.textTheme.bodyMedium?.copyWith(height: 1.5),
      ),

      // App bar: flat, left-aligned title, uses theme colours.
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),

      // Cards: rounded corners, thin outline and a soft background tint.
      cardTheme: CardThemeData(
        elevation: 0,
        color: colorScheme.surfaceContainerLow,
        margin: EdgeInsets.zero,
        shape: cardShape,
      ),

      // Buttons: rounded to match the cards.
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(shape: roundedShape),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(shape: roundedShape),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(shape: roundedShape),
      ),

      // Text fields: outlined with rounded corners.
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
      ),
    );
  }
}
