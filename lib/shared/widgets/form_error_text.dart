// form_error_text.dart
// A small red error message shown under radio groups and checkboxes.
// TextFormField shows its own errors, but these controls do not,
// so we draw the message ourselves in the same style.

import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';

/// Displays a validation error message using the theme's error colour.
/// StatelessWidget: it only shows the message it is given.
class FormErrorText extends StatelessWidget {
  /// The error message to show.
  final String message;

  const FormErrorText({super.key, required this.message});

  /// Builds the padded, red message text.
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.spacingMedium,
        AppConstants.spacingSmall,
        AppConstants.spacingMedium,
        0,
      ),
      child: Text(
        message,
        // Using the theme colour keeps it readable in light and dark mode.
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.error,
        ),
      ),
    );
  }
}
