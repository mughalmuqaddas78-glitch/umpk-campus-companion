// app_text_field.dart
// A reusable text field. The registration form needs four similar fields,
// so we write the styling once here instead of copying it four times.

import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';

/// A TextFormField with a label, hint, prefix icon, rounded outline border
/// and an optional validator.
/// StatelessWidget: the controller (owned by the parent screen) holds the text,
/// so this widget has nothing to remember itself.
class AppTextField extends StatelessWidget {
  /// Holds and controls the text typed by the user.
  /// The parent screen creates it and must dispose it.
  final TextEditingController controller;

  /// The floating label shown above the text.
  final String label;

  /// Light example text shown while the field is empty.
  final String hint;

  /// The icon shown at the start of the field.
  final IconData icon;

  /// Which on-screen keyboard to show (email, phone, plain text...).
  final TextInputType keyboardType;

  /// What the keyboard's action button does (e.g. "next" or "done").
  final TextInputAction textInputAction;

  /// How the keyboard capitalises letters (e.g. each word, or none).
  final TextCapitalization textCapitalization;

  /// Checks the text. Returns null if valid, or an error message if not.
  /// The surrounding Form calls it when validate() runs.
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
  });

  /// Builds the styled text field.
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
      ),
    );
  }
}
