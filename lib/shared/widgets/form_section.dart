// form_section.dart
// A form group: a heading on top and a Card underneath that holds
// related controls (for example "Residency").
// Used several times in the registration form, so it is shared.

import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';

/// A section heading followed by a Card containing any widgets.
/// StatelessWidget: it only displays what it is given.
class FormSection extends StatelessWidget {
  /// The heading text shown above the card.
  final String title;

  /// The controls shown inside the card (fields, radios, checkboxes...).
  final List<Widget> children;

  /// The space between the card edge and its content.
  /// The default suits list tiles; text fields pass a bigger value.
  final EdgeInsetsGeometry padding;

  const FormSection({
    super.key,
    required this.title,
    required this.children,
    this.padding = const EdgeInsets.symmetric(
      vertical: AppConstants.spacingSmall,
      horizontal: AppConstants.spacingSmall,
    ),
  });

  /// Builds the heading and the card below it.
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Semantics(header: true) lets screen readers announce this
        // text as a heading, which helps accessibility.
        Padding(
          padding: const EdgeInsets.only(
            left: AppConstants.spacingSmall,
            bottom: AppConstants.spacingSmall,
          ),
          child: Semantics(
            header: true,
            child: Text(
              title,
              // Theme text style + theme colour = readable in both modes.
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ),
      ],
    );
  }
}
