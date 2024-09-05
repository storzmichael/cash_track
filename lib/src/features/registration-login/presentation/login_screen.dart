import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/core/data/lang/app_text.dart';

import 'package:cash_track/src/core/presentation/theme_container.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:cash_track/src/features/general_widgets/presentation/outlined_big_button.dart';
import 'package:cash_track/src/features/registration-login/presentation/registration_screen.dart';
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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool rememberMe = false;
  final String correctPassword = '123';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Text(
          textFiles[language]![20],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          const ThemeContainer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(bottomPadding, sitesPadding, bottomPadding, sitesPadding),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: logoheight,
                          width: logowidth,
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
                        Text(
                          textFiles[language]![21],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  LoginTextFormField(
                    labelName: textFiles[language]![22],
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  LoginTextFormField(
                    labelName: textFiles[language]![23],
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
                          Navigator.pushNamed(context, "/apphome");
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(textFiles[language]![24])),
                          );
                        }
                      }
                    },
                    buttonName: textFiles[language]![20],
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
                            textFiles[language]![25],
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      Text(
                        textFiles[language]![26],
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  OutlinedBigButton(
                    buttonName: textFiles[language]![27],
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegistrastionScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 32)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
