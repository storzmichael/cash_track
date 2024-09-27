import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/core/presentation/theme_container.dart';
import 'package:cash_track/src/features/events/presentation/layout_widgets/event_grid.dart';
import 'package:flutter/material.dart';
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
          Text(
            textFiles[language]![21],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          textFiles[language]![0],
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      body: Stack(
        children: [
          const ThemeContainer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(40.0, sitesPadding, 40.0, sitesPadding),
            child: Column(
              children: [
                _logo(),
                const SizedBox(
                  height: 32,
                ),
                const EventGrid(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
