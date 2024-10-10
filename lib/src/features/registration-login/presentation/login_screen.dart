import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/core/presentation/app_home.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:cash_track/src/features/registration-login/presentation/shimmer_logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_text_field.dart';

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
        _errorMassage = textFiles[language]![69];
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
        _errorMassage = '${textFiles[language]![70]}: $e';
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

  Widget _loginButton() {
    return BigButton(
      onPressed: _signInWithEmailandPassword,
      buttonName: textFiles[language]![20],
    );
  }

  Widget _registerButton() {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, "/registration");
      },
      child: Text(
        textFiles[language]![27],
        style: Theme.of(context).textTheme.labelLarge,
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
                      _registerButton(),
                      Expanded(
                        child: SizedBox(),
                      ),
                      _testButton(),
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
