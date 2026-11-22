// validators.dart
// All form validation rules live here as reusable static methods.
// A validator returns null when the input is valid,
// or an error message (String) when it is not. That is the rule
// Flutter's TextFormField and FormField expect.

/// A container for reusable validation functions.
/// Private constructor: we never create an object, we only call
/// the static methods, e.g. Validators.fullName(text).
class Validators {
  Validators._();

  /// Full Name: required, at least 3 characters.
  /// Valid:   "Ayesha Khan", "Ali"
  /// Invalid: "" (empty), "Al" (too short), "   " (only spaces)
  static String? fullName(String? value) {
    final String text = value?.trim() ?? '';
    if (text.isEmpty) return 'Full name is required';
    if (text.length < 3) return 'Full name must be at least 3 characters';
    return null;
  }

  /// Roll Number: required, 4 to 15 characters,
  /// only letters, digits and hyphen.
  /// Valid:   "22-IT-001", "IT1234"
  /// Invalid: "" (empty), "A-1" (too short),
  ///          "22_IT@001" (illegal characters),
  ///          "22-IT-001-ABCDEFG" (more than 15 characters)
  static String? rollNumber(String? value) {
    final String text = value?.trim() ?? '';
    if (text.isEmpty) return 'Roll number is required';
    if (text.length < 4 || text.length > 15) {
      return 'Roll number must be 4 to 15 characters';
    }
    // ^...$ means the WHOLE text must match; + means one or more characters.
    if (!RegExp(r'^[A-Za-z0-9-]+$').hasMatch(text)) {
      return 'Use only letters, digits and hyphen (-)';
    }
    return null;
  }

  /// University Email: required and a valid email format
  /// (something@domain.ext).
  /// Valid:   "ayesha@umpk.edu.pk", "ali.raza@university.edu"
  /// Invalid: "" (empty), "ayesha" (no @),
  ///          "ayesha@" (no domain), "ayesha@uni" (no dot in domain)
  static String? email(String? value) {
    final String text = value?.trim() ?? '';
    if (text.isEmpty) return 'Email is required';
    final RegExp emailPattern = RegExp(
      r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9-]+(\.[A-Za-z0-9-]+)+$',
    );
    if (!emailPattern.hasMatch(text)) {
      return 'Enter a valid email, e.g. name@university.edu.pk';
    }
    return null;
  }

  /// Mobile Number: required, exactly 11 digits, starting with 03.
  /// Valid:   "03001234567", "03451234567"
  /// Invalid: "" (empty), "0300123456" (only 10 digits),
  ///          "04001234567" (does not start with 03),
  ///          "0300-1234567" (contains a hyphen)
  static String? mobileNumber(String? value) {
    final String text = value?.trim() ?? '';
    if (text.isEmpty) return 'Mobile number is required';
    if (!RegExp(r'^\d{11}$').hasMatch(text)) {
      return 'Mobile number must be exactly 11 digits';
    }
    if (!text.startsWith('03')) {
      return 'Mobile number must start with 03';
    }
    return null;
  }

  /// Required choice: used for the Residency radio group.
  /// The /// The `T` means it works with any type (here, the Residency enum). means it works with any type (here, the Residency enum).
  /// Valid:   Residency.dayScholar
  /// Invalid: null (nothing selected)
  static String? requiredSelection<T>(
    T? value, {
    String message = 'Please choose an option',
  }) {
    return value == null ? message : null;
  }

  /// Must be ticked: used for the confirmation checkbox.
  /// Valid:   true
  /// Invalid: false or null (not ticked)
  static String? mustBeChecked(
    bool? value, {
    String message = 'You must confirm before registering',
  }) {
    return value == true ? null : message;
  }
}
