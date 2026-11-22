// home_screen.dart
// The first screen of the app. It shows a welcome card and a button
// that opens the Student Registration screen.

import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../shared/widgets/welcome_card.dart';
import '../profile/registration_screen.dart';

/// The home screen of UMPK Campus Companion.
/// StatelessWidget: nothing on this screen changes yet.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  /// Opens the registration screen on top of the home screen.
  /// Navigator.push adds a new page to the navigation stack;
  /// the back button in its AppBar pops it off again.
  void _openRegistration(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const RegistrationScreen(),
      ),
    );
  }

  /// Builds the screen layout.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.appName)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppConstants.spacingMedium),
          children: <Widget>[
            const WelcomeCard(
              title: 'Welcome!',
              message:
                  'Your all-in-one companion for campus life. '
                  'Create your profile to get started.',
            ),
            const SizedBox(height: AppConstants.spacingMedium),
            FilledButton.icon(
              onPressed: () => _openRegistration(context),
              icon: const Icon(Icons.person_add_alt_1_rounded),
              label: const Text('Create Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
