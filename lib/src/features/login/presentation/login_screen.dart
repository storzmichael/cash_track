import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/core/presentation/app_home.dart';
import 'package:cash_track/src/core/presentation/theme_container.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'login_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool rememberMe = false;
  final String correctPassword = '1234567';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: const Text(
          'Login Screen',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          const ThemeContainer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, sitesPadding, 16.0, sitesPadding),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 150,
                          width: 320,
                          child: Image(
                            image: AssetImage('assets/logo/logo.png'),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        SizedBox(
                          child: Shimmer.fromColors(
                            period: const Duration(milliseconds: 3000),
                            loop: 3,
                            baseColor: Colors.black,
                            highlightColor: Colors.grey,
                            child: const Text(
                              'CashTrack',
                              style: TextStyle(fontFamily: 'RubikOne', fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const Text(
                          'Einfach Smart Kassieren',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  LoginTextFormField(
                    labelName: 'E-mail',
                    hintText: 'E-mail',
                    controller: userController,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  LoginTextFormField(
                    labelName: 'Password',
                    hintText: 'Password',
                    isPassword: true,
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BigButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (passwordController.text == correctPassword) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AppHome()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Incorrect password')),
                          );
                        }
                      }
                    },
                    buttonName: 'Login',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: rememberMe,
                            onChanged: (bool? value) {
                              setState(() {
                                rememberMe = value ?? false;
                              });
                            },
                          ),
                          Text(
                            'Remember Me',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      Text(
                        'Passwort vergessen?',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
