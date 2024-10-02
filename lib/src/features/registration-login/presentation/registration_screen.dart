import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/core/presentation/app_home.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/core/presentation/theme_container.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:cash_track/src/features/registration-login/presentation/shimmer_logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_text_field.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? _errorMassage = '';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _createUserWithEmailandPassword() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _errorMassage = textFiles[language]![50];
      });
      _errorAlert();
      return;
    }

    try {
      // Überprüfen, ob ein Konto mit der E-Mail-Adresse existiert
      final signInMethods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(_emailController.text);

      if (signInMethods.isNotEmpty) {
        // Konto existiert bereits
        setState(() {
          _errorMassage = textFiles[language]![51];
        });
        _errorAlert();
        return;
      }

      // Konto erstellen, wenn es nicht existiert
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Nur bei erfolgreicher Registrierung zum nächsten Bildschirm wechseln
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const AppHome()),
        (route) => false, // Entfernt alle vorherigen Routen
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMassage = e.message ?? textFiles[language]![52];
      });
      _errorAlert();
    } catch (e) {
      setState(() {
        _errorMassage = '${textFiles[language]![52]}: $e';
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
            title: Text(textFiles[language]![54]),
            content: Text(
              _errorMassage!,
              style: const TextStyle(fontSize: 13, color: alertColor),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(textFiles[language]![55]),
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
    return LoginTextField(
      labelName: textFiles[language]![22],
      controller: _emailController,
      prefixIcon: const Icon(Icons.person_2_outlined),
    );
  }

  Widget _passwordTextField() {
    return LoginTextField(
      labelName: textFiles[language]![23],
      isPassword: true,
      controller: _passwordController,
      prefixIcon: const Icon(Icons.lock_outline_rounded),
    );
  }

  Widget _registerButton() {
    return BigButton(
      onPressed: _createUserWithEmailandPassword,
      buttonName: textFiles[language]![35],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(textFiles[language]![48]),
      ),
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
                padding: const EdgeInsets.fromLTRB(bottomPadding, 0, bottomPadding, sitesPadding),
                child: Column(
                  children: [
                    _logo(),
                    const SizedBox(
                      height: 50,
                    ),
                    _emailTextField(),
                    const SizedBox(
                      height: 8,
                    ),
                    _passwordTextField(),
                    const SizedBox(
                      height: 16,
                    ),
                    _registerButton(),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
