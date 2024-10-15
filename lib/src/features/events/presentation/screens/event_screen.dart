import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/events/presentation/layout_widgets/event_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cash_track/src/features/settings/application/language_provider.dart'; // Importiere den LanguageProvider
import 'package:shimmer/shimmer.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  Widget _logo() {
    return Center(
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
              loop: 1,
              baseColor: Colors.black,
              highlightColor: Colors.grey,
              child: const Text(
                'CashTrack',
                style: TextStyle(fontFamily: 'RubikOne', fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Consumer<LanguageProvider>(
            builder: (context, languageProvider, child) {
              return Text(
                textFiles[languageProvider.language]![21], // Dynamischer Text
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context); // Zugriff auf den LanguageProvider

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          textFiles[languageProvider.language]![0], // Dynamischer Titel
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
                padding: const EdgeInsets.fromLTRB(40.0, sitesPadding, 40.0, sitesPadding),
                child: Column(
                  children: [
                    _logo(),
                    const SizedBox(height: 32),
                    const EventGrid(),
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
