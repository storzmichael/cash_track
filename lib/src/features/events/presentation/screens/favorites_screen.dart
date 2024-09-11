import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/core/presentation/theme_container.dart';
import 'package:cash_track/src/features/events/presentation/layout_widgets/event_list.dart';

import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        ThemeContainer(),
        Padding(
          padding: EdgeInsets.all(sitesPadding),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  height: 150,
                  child: Image(
                    image: AssetImage(appImagePath),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              EventList(),
            ],
          ),
        ),
      ],
    );
  }
}
