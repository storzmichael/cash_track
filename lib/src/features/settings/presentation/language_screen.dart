import 'package:cash_track/src/features/settings/application/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cash_track/src/core/presentation/theme_container.dart';
import 'package:cash_track/src/data/lang/app_text.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

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
      color: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          textFiles[languageProvider.language]![58], // Titel für die Spracheinstellungen
        ),
      ),
      body: Stack(
        children: [
          const ThemeContainer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              children: [
                // Sprache: Deutsch
                _buildListTile(
                  context,
                  icon: Icons.language,
                  title: 'Deutsch',
                  onTap: () {
                    languageProvider.setLanguage('Deutsch');
                  },
                ),
                _buildDivider(),

                // Sprache: Englisch
                _buildListTile(
                  context,
                  icon: Icons.language,
                  title: 'English',
                  onTap: () {
                    languageProvider.setLanguage('English');
                  },
                ),
                _buildDivider(),

                // Weitere Einstellungen...
              ],
            ),
          ),
        ],
      ),
    );
  }
}
