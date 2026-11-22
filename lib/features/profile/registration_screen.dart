// registration_screen.dart
// The Student Registration screen with validation and a polished layout.
// It is a StatefulWidget because radio, checkbox and switch values change
// while the user interacts, and the screen must redraw when they do.

import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../core/utils/validators.dart';
import '../../shared/widgets/app_text_field.dart';
import '../../shared/widgets/form_error_text.dart';
import '../../shared/widgets/form_section.dart';

/// The two residency choices a student can pick from.
/// An enhanced enum: each value also carries a readable label,
/// which we reuse in the summary dialog.
enum Residency {
  dayScholar('Day Scholar'),
  hostelResident('Hostel Resident');

  /// Creates a value with its display label.
  const Residency(this.label);

  /// The human-friendly name shown to the user.
  final String label;
}

/// The registration screen widget.
/// It only creates its State object; the real work happens in the State class.
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  /// Creates the State object that stores this screen's changing data.
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

/// Holds the form data, runs validation and builds the registration UI.
class _RegistrationScreenState extends State<RegistrationScreen> {
  /// The key that gives us access to the Form, so we can call
  /// validate() and reset().
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Lets us scroll the page back to the top after clearing the form.
  final ScrollController _scrollController = ScrollController();

  // One controller per text field, so we can read each value later.
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rollController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  /// The selected residency. Null means nothing is selected yet.
  Residency? _residency;

  /// Campus interests: each name maps to true (ticked) or false.
  final Map<String, bool> _interests = <String, bool>{
    'Sports': false,
    'Societies': false,
    'Library': false,
  };

  /// State of the two switches.
  bool _classReminders = false;
  bool _emailNotices = false;

  /// Frees the memory used by the controllers when the screen closes.
  /// Without this, the app would slowly leak memory.
  @override
  void dispose() {
    _nameController.dispose();
    _rollController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// Runs when the user presses Register.
  /// Valid form: show a SnackBar and a summary dialog.
  /// Invalid form: Flutter shows every error message at once.
  void _onRegisterPressed() {
    // Hide the keyboard so the messages are easy to see.
    FocusScope.of(context).unfocus();

    // validate() runs every validator inside the Form.
    // It returns true only if ALL of them return null.
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful')),
      );
      _showSummaryDialog();
    }
  }

  /// Runs when the user presses Clear Form.
  /// Empties every field, unticks every option and hides all error messages.
  void _onClearPressed() {
    // Close the keyboard first.
    FocusScope.of(context).unfocus();

    // Empty the four text fields.
    _nameController.clear();
    _rollController.clear();
    _emailController.clear();
    _mobileController.clear();

    // Reset our own stored choices and redraw the screen.
    setState(() {
      _residency = null;
      _interests.updateAll((String name, bool ticked) => false);
      _classReminders = false;
      _emailNotices = false;
    });

    // reset() sends every field in the Form back to its starting value
    // and removes any error message (including the radio and confirmation).
    _formKey.currentState?.reset();

    // Smoothly scroll back to the top so the user sees a fresh form.
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  /// Shows an AlertDialog that summarises the data the student entered.
  void _showSummaryDialog() {
    // Collect the names of the ticked interests.
    final List<String> chosenInterests = <String>[
      for (final MapEntry<String, bool> entry in _interests.entries)
        if (entry.value) entry.key,
    ];

    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Registration Summary'),
          // Scrollable so the dialog never overflows on small screens.
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildSummaryRow('Full Name', _nameController.text.trim()),
                _buildSummaryRow('Roll Number', _rollController.text.trim()),
                _buildSummaryRow('Email', _emailController.text.trim()),
                _buildSummaryRow('Mobile', _mobileController.text.trim()),
                _buildSummaryRow('Residency', _residency?.label ?? '-'),
                _buildSummaryRow(
                  'Interests',
                  chosenInterests.isEmpty ? 'None' : chosenInterests.join(', '),
                ),
                _buildSummaryRow(
                  'Class reminders',
                  _classReminders ? 'On' : 'Off',
                ),
                _buildSummaryRow(
                  'Email notices',
                  _emailNotices ? 'On' : 'Off',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              // Closes only the dialog, not the registration screen.
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  /// Builds one "Label: value" line for the summary dialog.
  /// The label is bold so the two parts are easy to tell apart.
  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.spacingSmall),
      child: Text.rich(
        TextSpan(
          children: <InlineSpan>[
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  /// Builds the whole screen.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Registration')),

      // SafeArea avoids notches and system bars.
      body: SafeArea(
        // Center + ConstrainedBox stop the form from stretching too wide
        // on tablets or large phones in landscape. On small phones the
        // form simply fills the width.
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            // Scrolls when the content is taller than the screen,
            // for example when the keyboard is open.
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.all(AppConstants.spacingMedium),
              // The Form groups all fields so they can be validated together.
              child: Form(
                key: _formKey,
                // Each field shows its error only AFTER the user has
                // interacted with it, so the form starts clean.
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _buildPersonalDetailsSection(),
                    const SizedBox(height: AppConstants.spacingLarge),
                    _buildResidencySection(),
                    const SizedBox(height: AppConstants.spacingLarge),
                    _buildInterestsSection(),
                    const SizedBox(height: AppConstants.spacingLarge),
                    _buildPreferencesSection(),
                    const SizedBox(height: AppConstants.spacingLarge),
                    _buildConfirmationSection(),
                    const SizedBox(height: AppConstants.spacingLarge),
                    _buildRegisterButton(),
                    const SizedBox(height: AppConstants.spacingMedium),
                    _buildClearButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the Personal Details card with the four text fields.
  /// Each field gets its rule from the Validators class.
  /// TextInputAction.next moves to the next field; the last one uses done.
  Widget _buildPersonalDetailsSection() {
    return FormSection(
      title: 'Personal Details',
      // Text fields need more breathing room than list tiles.
      padding: const EdgeInsets.all(AppConstants.spacingMedium),
      children: <Widget>[
        AppTextField(
          controller: _nameController,
          label: 'Full Name',
          hint: 'e.g. Ayesha Khan',
          icon: Icons.person_outline,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          validator: Validators.fullName,
        ),
        const SizedBox(height: AppConstants.spacingMedium),
        AppTextField(
          controller: _rollController,
          label: 'Roll Number',
          hint: 'e.g. 22-IT-001',
          icon: Icons.badge_outlined,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.characters,
          validator: Validators.rollNumber,
        ),
        const SizedBox(height: AppConstants.spacingMedium),
        AppTextField(
          controller: _emailController,
          label: 'University Email',
          hint: 'name@university.edu.pk',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: Validators.email,
        ),
        const SizedBox(height: AppConstants.spacingMedium),
        AppTextField(
          controller: _mobileController,
          label: 'Mobile Number',
          hint: 'e.g. 03001234567',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          // Last field: the keyboard button closes the keyboard.
          textInputAction: TextInputAction.done,
          validator: Validators.mobileNumber,
        ),
      ],
    );
  }

  /// Builds the Residency radio group (required, only one can be chosen).
  /// A FormField wraps the radios so the Form can validate them and we can
  /// show an error message below the group.
  Widget _buildResidencySection() {
    return FormSection(
      title: 'Residency',
      children: <Widget>[
        // No initialValue here: the starting value is "nothing selected",
        // so Clear Form (reset) always returns the group to empty.
        FormField<Residency>(
          validator: (Residency? value) {
            return Validators.requiredSelection<Residency>(
              value,
              message: 'Please select your residency',
            );
          },
          builder: (FormFieldState<Residency> field) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // RadioGroup keeps track of which radio is selected.
                RadioGroup<Residency>(
                  groupValue: field.value,
                  onChanged: (Residency? value) {
                    // didChange tells the FormField about the new value
                    // (and clears the error); setState redraws our screen.
                    field.didChange(value);
                    setState(() => _residency = value);
                  },
                  child: const Column(
                    children: <Widget>[
                      RadioListTile<Residency>(
                        value: Residency.dayScholar,
                        title: Text('Day Scholar'),
                      ),
                      RadioListTile<Residency>(
                        value: Residency.hostelResident,
                        title: Text('Hostel Resident'),
                      ),
                    ],
                  ),
                ),
                // Only shown when validation failed.
                if (field.hasError) FormErrorText(message: field.errorText!),
              ],
            );
          },
        ),
      ],
    );
  }

  /// Builds the Campus Interests checkboxes (any number can be ticked).
  Widget _buildInterestsSection() {
    return FormSection(
      title: 'Campus Interests',
      children: <Widget>[
        // Make one checkbox for each entry in the _interests map.
        for (final MapEntry<String, bool> entry in _interests.entries)
          CheckboxListTile(
            title: Text(entry.key),
            value: entry.value,
            onChanged: (bool? checked) {
              setState(() => _interests[entry.key] = checked ?? false);
            },
          ),
      ],
    );
  }

  /// Builds the two on/off preference switches.
  Widget _buildPreferencesSection() {
    return FormSection(
      title: 'Preferences',
      children: <Widget>[
        SwitchListTile(
          title: const Text('Enable class reminders'),
          value: _classReminders,
          onChanged: (bool value) {
            setState(() => _classReminders = value);
          },
        ),
        SwitchListTile(
          title: const Text('Receive university notices by email'),
          value: _emailNotices,
          onChanged: (bool value) {
            setState(() => _emailNotices = value);
          },
        ),
      ],
    );
  }

  /// Builds the confirmation checkbox that must be ticked to register.
  /// It is a FormField so validate() also checks it.
  Widget _buildConfirmationSection() {
    return FormSection(
      title: 'Confirmation',
      children: <Widget>[
        FormField<bool>(
          initialValue: false,
          validator: Validators.mustBeChecked,
          builder: (FormFieldState<bool> field) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CheckboxListTile(
                  title: const Text('I confirm that the information is correct'),
                  value: field.value ?? false,
                  onChanged: (bool? checked) => field.didChange(checked),
                ),
                if (field.hasError) FormErrorText(message: field.errorText!),
              ],
            );
          },
        ),
      ],
    );
  }

  /// Builds the full-width Register button.
  /// Pressing it starts validation (see _onRegisterPressed).
  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity, // full width
      height: 52, // comfortable tap size
      child: FilledButton(
        onPressed: _onRegisterPressed,
        child: const Text('Register'),
      ),
    );
  }

  /// Builds the full-width Clear Form button.
  /// It is outlined (less prominent) so it is not confused with Register.
  Widget _buildClearButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: _onClearPressed,
        icon: const Icon(Icons.refresh_rounded),
        label: const Text('Clear Form'),
      ),
    );
  }
}
