import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Importiere Firebase Auth
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = Colors.black,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 0.1,
      color: whiteColor,
    );
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Hier kannst du den Benutzer zur Anmeldeseite weiterleiten oder eine andere Aktion durchführen
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacementNamed("/"); // Beispiel
    } catch (e) {
      // Fehlerbehandlung
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${textFiles[language]![56]}: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          textFiles[language]![49],
          style: Theme.of(context).textTheme.labelLarge,
        ),
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
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView(
                  children: [
                    // Profil
                    _buildListTile(
                      context,
                      icon: Icons.person,
                      title: textFiles[language]![2],
                      onTap: () {
                        // Hier kannst du die Navigationslogik zu deinem Profil-Screen hinzufügen
                      },
                    ),
                    _buildDivider(),

                    // Datenschutz
                    _buildListTile(
                      context,
                      icon: Icons.lock,
                      title: textFiles[language]![57],
                      onTap: () {
                        // Hier kannst du die Navigationslogik zu Datenschutz-Einstellungen hinzufügen
                      },
                    ),
                    _buildDivider(),

                    // Benachrichtigungen
                    _buildListTile(
                      context,
                      icon: Icons.language,
                      title: textFiles[language]![58],
                      onTap: () {
                        Navigator.pushNamed(context, "/language");
                      },
                    ),
                    _buildDivider(),

                    // Chats
                    _buildListTile(
                      context,
                      icon: Icons.devices,
                      title: textFiles[language]![59],
                      onTap: () {
                        // Hier kannst du die Navigationslogik zu Chat-Einstellungen hinzufügen
                      },
                    ),
                    _buildDivider(),

                    // Hilfe
                    _buildListTile(
                      context,
                      icon: Icons.help,
                      title: textFiles[language]![60],
                      onTap: () {
                        // Hier kannst du die Navigationslogik zu Hilfe-Seite hinzufügen
                      },
                    ),
                    _buildDivider(),

                    // Abmelden
                    _buildListTile(
                      context,
                      icon: Icons.exit_to_app,
                      title: textFiles[language]![61],
                      onTap: () {
                        _signOut(context);
                      },
                      color: alertColor,
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
