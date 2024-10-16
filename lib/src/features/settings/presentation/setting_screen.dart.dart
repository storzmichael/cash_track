import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Importiere Firebase Auth
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cash_track/src/features/settings/application/language_provider.dart';

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
      Navigator.of(context).pushReplacementNamed("/"); // Beispiel
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${textFiles[language]![56]}: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          textFiles[languageProvider.language]![49], // Titel für die Einstellungen
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
                      title: textFiles[languageProvider.language]![2], // Profil
                      onTap: () {
                        // Navigationslogik zu deinem Profil-Screen hinzufügen
                      },
                    ),
                    _buildDivider(),

                    // Datenschutz
                    _buildListTile(
                      context,
                      icon: Icons.lock,
                      title: textFiles[languageProvider.language]![57], // Datenschutz
                      onTap: () {
                        // Navigationslogik zu Datenschutz-Einstellungen hinzufügen
                      },
                    ),
                    _buildDivider(),

                    // Sprache
                    _buildListTile(
                      context,
                      icon: Icons.language,
                      title: textFiles[languageProvider.language]![58], // Sprache
                      onTap: () {
                        Navigator.pushNamed(context, "/language");
                      },
                    ),
                    _buildDivider(),

                    // Chats
                    _buildListTile(
                      context,
                      icon: Icons.devices,
                      title: textFiles[languageProvider.language]![59], // Chats
                      onTap: () {
                        // Navigationslogik zu Chat-Einstellungen hinzufügen
                      },
                    ),
                    _buildDivider(),

                    // Hilfe
                    _buildListTile(
                      context,
                      icon: Icons.help,
                      title: textFiles[languageProvider.language]![60], // Hilfe
                      onTap: () {
                        // Navigationslogik zu Hilfe-Seite hinzufügen
                      },
                    ),
                    _buildDivider(),

                    // Abmelden
                    _buildListTile(
                      context,
                      icon: Icons.exit_to_app,
                      title: textFiles[languageProvider.language]![61], // Abmelden
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
