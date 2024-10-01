import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/core/presentation/theme_container.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          textFiles[language]![58],
        ),
      ),
      body: Stack(
        children: [
          const ThemeContainer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              children: [
                // Profil
                _buildListTile(
                  context,
                  icon: Icons.language,
                  title: textFiles[language]![62],
                  onTap: () {
                    setState(() {
                      language = 'Deutsch';
                    });
                  },
                ),
                _buildDivider(),

                // Datenschutz
                _buildListTile(context, icon: Icons.lock, title: textFiles[language]![63], onTap: () {
                  setState(() {
                    language = 'English';
                  });
                }),
                _buildDivider(),

                // Benachrichtigungen
              ],
            ),
          ),
        ],
      ),
    );
  }
}
