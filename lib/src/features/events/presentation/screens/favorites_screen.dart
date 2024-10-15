import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/events/presentation/layout_widgets/event_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cash_track/src/features/settings/application/language_provider.dart'; // Importiere den LanguageProvider

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  Widget _logo() {
    return const Center(
      child: SizedBox(
        height: 150,
        child: Image(
          image: AssetImage(appImagePath),
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context); // Zugriff auf den LanguageProvider

    return Scaffold(
      appBar: AppBar(
        title: Text(
          textFiles[languageProvider.language]![1], // Dynamischer Text
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
                padding: const EdgeInsets.all(sitesPadding),
                child: Column(
                  children: [
                    _logo(),
                    const SizedBox(height: 32),
                    const EventList(),
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
