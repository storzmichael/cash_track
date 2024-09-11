import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
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
  final TextEditingController userController = TextEditingController(); // Controller für den Benutzernamen
  final TextEditingController emailController = TextEditingController(); // Controller für die E-Mail-Adresse
  final TextEditingController passwordController = TextEditingController(); // Controller für das Passwort
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Schlüssel für das Formular

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Text(
          textFiles[language]![20], // Titel der AppBar
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          const ThemeContainer(), // Hintergrundthema
          Padding(
            padding: const EdgeInsets.fromLTRB(bottomPadding, sitesPadding, bottomPadding, sitesPadding),
            child: Form(
              key: _formKey, // Schlüssel für die Formularvalidierung
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: logoheight,
                          width: logowidth,
                          child: Image(
                            image: AssetImage(appImagePath), // Logo der App
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
                              appName, // Name der App mit Schimmer-Effekt
                              style: TextStyle(fontFamily: 'RubikOne', fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Text(
                          textFiles[language]![21], // Zusätzlicher Text unter dem Logo
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  // BENUTZERNAME TEXTFELD
                  LoginTextFormField(
                    labelName: textFiles[language]![33], // Bezeichnung des Benutzernamenfeldes
                    isUsername: true,
                    controller: userController,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  // E-MAIL TEXTFELD
                  LoginTextFormField(
                    labelName: textFiles[language]![22], // Bezeichnung des E-Mail-Feldes
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  // PASSWORT TEXTFELD
                  LoginTextFormField(
                    labelName: textFiles[language]![23], // Bezeichnung des Passwortfeldes
                    isPassword: true,
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BigButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Formularvalidierung
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AppHome()), // Navigation zur Hauptseite
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(textFiles[language]![34]), // Fehlermeldung bei ungültiger Eingabe
                          ),
                        );
                      }
                    },
                    buttonName: textFiles[language]![35], // Text des Buttons
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
