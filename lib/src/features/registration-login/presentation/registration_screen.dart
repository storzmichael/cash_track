import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/core/presentation/app_home.dart';
import 'package:cash_track/src/core/presentation/theme_container.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'login_text_form_field.dart';

class RegistrastionScreen extends StatefulWidget {
  const RegistrastionScreen({super.key});

  @override
  State<RegistrastionScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrastionScreen> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: const Text(
          'Login Screen',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
                  // USERNAME TEXTFIELD
                  LoginTextFormField(
                    labelName: 'Username',
                    isUsername: true,
                    controller: userController,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  //EMAIL TEXTFIELD
                  LoginTextFormField(
                    labelName: 'E-mail',
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  //PASSWORT TEXTFIELD
                  LoginTextFormField(
                    labelName: 'Passwort',
                    isPassword: true,
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BigButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AppHome()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Eingaben ungültig'),
                          ),
                        );
                      }
                    },
                    buttonName: 'Registrierung abschließen',
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
