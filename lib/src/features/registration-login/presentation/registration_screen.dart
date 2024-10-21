import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/core/presentation/app_home.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/core/presentation/theme_container.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:cash_track/src/features/registration-login/presentation/shimmer_logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cash_track/src/features/settings/application/language_provider.dart';
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
      final signInMethods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(_emailController.text);

      if (signInMethods.isNotEmpty) {
        setState(() {
          _errorMassage = textFiles[language]![51];
        });
        _errorAlert();
        return;
      }

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const AppHome()),
        (route) => false,
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
    final languageProvider = Provider.of<LanguageProvider>(context); // Zugriff auf den LanguageProvider
    return LoginTextField(
      labelName: textFiles[languageProvider.language]![22], // Dynamischer Label-Text
      controller: _emailController,
      prefixIcon: const Icon(Icons.person_2_outlined),
    );
  }

  Widget _passwordTextField() {
    final languageProvider = Provider.of<LanguageProvider>(context); // Zugriff auf den LanguageProvider
    return LoginTextField(
      labelName: textFiles[languageProvider.language]![23], // Dynamischer Label-Text
      isPassword: true,
      controller: _passwordController,
      prefixIcon: const Icon(Icons.lock_outline_rounded),
    );
  }

  Widget _registerButton() {
    final languageProvider = Provider.of<LanguageProvider>(context); // Zugriff auf den LanguageProvider
    return BigButton(
      onPressed: _createUserWithEmailandPassword,
      buttonName: textFiles[languageProvider.language]![35], // Dynamischer Button-Text
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          const ThemeContainer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(bottomPadding, 0, bottomPadding, sitesPadding),
            child: Column(
              children: [
                const SizedBox(height: 0),
                _logo(),
                const SizedBox(height: 50),
                _emailTextField(),
                const SizedBox(height: 8),
                _passwordTextField(),
                const SizedBox(height: 16),
                _registerButton(),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
