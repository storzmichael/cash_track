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
          padding: EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 16),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  height: 150,
                  child: Image(
                    image: AssetImage('assets/logo/logo.png'),
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
