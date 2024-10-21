import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/core/presentation/app_home.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:cash_track/src/features/registration-login/domain/password_reset_service.dart';
import 'package:cash_track/src/features/registration-login/presentation/shimmer_logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importiere Provider
import 'login_text_field.dart';
import 'package:cash_track/src/features/settings/application/language_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _errorMassage = '';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signInWithEmailandPassword() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _errorMassage = textFiles[language]![69]; // Fehlertext für leere Eingaben
      });
      _errorAlert();
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (userCredential.user != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AppHome()),
          (route) => false, // Entfernt alle vorherigen Routen
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMassage = e.message;
      });
      _errorAlert();
    } catch (e) {
      setState(() {
        _errorMassage = '${textFiles[language]![70]}: $e'; // Unerwarteter Fehler
      });
      _errorAlert();
    }
  }

  void _errorAlert() {
    if (_errorMassage != null && _errorMassage!.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(textFiles[language]![54]), // Fehlerdialog-Titel
            content: Text(
              _errorMassage!,
              style: const TextStyle(fontSize: 13, color: alertColor),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(textFiles[language]![55]), // Dialog-Button
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Widget _logo() {
    return const ShimmerLogo();
  }

  Widget _emailTextField() {
    final languageProvider = Provider.of<LanguageProvider>(context); // Zugriff auf den LanguageProvider
    return LoginTextField(
      labelName: textFiles[languageProvider.language]![22], // E-Mail-Label
      controller: _emailController,
      prefixIcon: const Icon(Icons.person_2_outlined),
    );
  }

  Widget _passwordTextField() {
    final languageProvider = Provider.of<LanguageProvider>(context); // Zugriff auf den LanguageProvider
    return LoginTextField(
      labelName: textFiles[languageProvider.language]![23], // Passwort-Label
      isPassword: true,
      controller: _passwordController,
      prefixIcon: const Icon(Icons.lock_outline_rounded),
    );
  }

  Widget _loginButton() {
    final languageProvider = Provider.of<LanguageProvider>(context); // Zugriff auf den LanguageProvider
    return BigButton(
      onPressed: _signInWithEmailandPassword,
      buttonName: textFiles[languageProvider.language]![20], // Login-Button-Text
    );
  }

  Widget _registerButton() {
    final languageProvider = Provider.of<LanguageProvider>(context); // Zugriff auf den LanguageProvider
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, "/registration");
      },
      child: Text(
        textFiles[languageProvider.language]![27], // Registrierung-Button-Text
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }

  Widget _passwordForgotButton() {
    final languageProvider = Provider.of<LanguageProvider>(context); // Zugriff auf den LanguageProvider
    return TextButton(
      onPressed: () {
        showPasswordResetDialog(
          context,
        );
      },
      child: Text(
        textFiles[languageProvider.language]![84], // Registrierung-Button-Text
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }

  Widget _testButton() {
    return BigButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, "/appHome");
      },
      buttonName: 'test',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    lightThemeList[0],
                    lightThemeList[1],
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(bottomPadding, sitesPadding, bottomPadding, sitesPadding),
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 100),
                      _logo(),
                      const SizedBox(height: 50),
                      _emailTextField(),
                      const SizedBox(height: 8),
                      _passwordTextField(),
                      const SizedBox(height: 16),
                      _loginButton(),
                      Row(
                        children: [
                          _passwordForgotButton(),
                          Expanded(child: SizedBox()),
                          _registerButton(),
                        ],
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      const SizedBox(height: bottomSafeArea),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
