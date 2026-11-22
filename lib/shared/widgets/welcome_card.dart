// welcome_card.dart
// A reusable card that shows an icon, a title and a message.
// It lives in "shared" because any feature may want to reuse it.

import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';

/// A friendly card used to greet the user.
/// StatelessWidget: it only displays the values given to it.
class WelcomeCard extends StatelessWidget {
  /// The big heading text of the card.
  final String title;

  /// The smaller description text under the heading.
  final String message;

  /// The icon shown at the top of the card.
  final IconData icon;

  const WelcomeCard({
    super.key,
    required this.title,
    required this.message,
    this.icon = Icons.school_rounded,
  });

  /// Lays out the icon, title and message vertically inside a Card.
  @override
  Widget build(BuildContext context) {
    // Theme.of(context) gives us the colours and text styles from AppTheme,
    // so we never hard-code them here.
    final ThemeData theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(icon, size: 40, color: theme.colorScheme.primary),
            const SizedBox(height: AppConstants.spacingMedium),
            Text(title, style: theme.textTheme.headlineSmall),
            const SizedBox(height: AppConstants.spacingSmall),
            Text(message, style: theme.textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
