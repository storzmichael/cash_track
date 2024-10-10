import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/events/presentation/layout_widgets/event_list.dart';

import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          textFiles[language]![1],
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(sitesPadding),
        child: Column(
          children: [
            _logo(),
            const SizedBox(
              height: 32,
            ),
            const EventList(),
          ],
        ),
      ),
    );
  }
}
