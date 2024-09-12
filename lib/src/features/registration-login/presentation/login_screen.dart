import 'package:cash_track/src/config/config.dart';

import 'package:cash_track/src/data/lang/app_text.dart';

import 'package:cash_track/src/core/presentation/theme_container.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';

import 'package:cash_track/src/features/registration-login/presentation/registration_screen.dart';
import 'package:cash_track/src/features/registration-login/presentation/shimmer_logo.dart';
import 'package:flutter/material.dart';

import 'login_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController(); // Controller für das E-Mail-Feld
  final TextEditingController _passwordController = TextEditingController(); // Controller für das Passwortfeld

  bool rememberMe = false; // Status für die "Angemeldet bleiben"-Checkbox
  final String correctPassword = '123'; // Korrektes Passwort für die Anmeldung

  Widget _logo() {
    return const ShimmerLogo();
  }

  Widget _emailTextField() {
    return LoginTextField(
      labelName: textFiles[language]![22], // Label für das E-Mail-Feld
      controller: _emailController, // Controller für das E-Mail-Feld
      prefixIcon: const Icon(Icons.person_2_outlined),
    );
  }

  Widget _passwordTextField() {
    return LoginTextField(
      labelName: textFiles[language]![23], // Label für das E-Mail-Feld
      isPassword: true,
      controller: _passwordController, // Controller für das E-Mail-Feld
      prefixIcon: const Icon(Icons.lock_outline_rounded),
    );
  }

  Widget _loginButton() {
    return BigButton(
      onPressed: () {},
      buttonName: textFiles[language]![20], // Name des Anmeldebuttons aus der Sprachdatei
    );
  }

  // ignore: unused_element
  Widget _passwordForgottenButton() {
    return TextButton(
      onPressed: () {
        // Aktion bei Passwort zurücksetzen
      },
      child: Text(
        textFiles[language]![26], // Text für "Passwort zurücksetzen"
        style: Theme.of(context).textTheme.bodySmall, // Textstil
      ),
    );
  }

  Widget _guestButton() {
    return BigButton(
      onPressed: () {
        // Aktion bei Gast-Anmelde
      },
      buttonName: textFiles[language]![47], // Name des Buttons für den Gast-Anmelde aus der Sprachdatei
    );
  }

  Widget _registerButton() {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegistrastionScreen()), // Navigation zur Registrierungsseite
        );
      },
      child: Text(
        textFiles[language]![27],
        style: Theme.of(context).textTheme.labelLarge,
      ),
      // Name des Buttons für die Registrierung aus der Sprachdatei
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const ThemeContainer(), // Hintergrund-Themencontainer
          Padding(
            padding: const EdgeInsets.fromLTRB(
                bottomPadding, sitesPadding, bottomPadding, sitesPadding), // Padding um den Inhalt
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                _logo(),
                const SizedBox(
                  height: 124,
                ),
                _emailTextField(),
                const SizedBox(
                  height: 8,
                ),
                _passwordTextField(),
                const SizedBox(
                  height: 32,
                ),
                _loginButton(),
                _registerButton(),
                const Expanded(child: SizedBox()),
                _guestButton(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
