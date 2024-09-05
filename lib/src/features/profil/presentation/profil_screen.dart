import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/core/data/lang/app_text.dart';
import 'package:cash_track/src/core/presentation/theme_container.dart';
import 'package:cash_track/src/features/general_widgets/presentation/outlined_big_button.dart';
import 'package:cash_track/src/features/profil/presentation/circle_avatar_widget.dart';

import 'package:flutter/material.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ThemeContainer(),
        Padding(
          padding: const EdgeInsets.all(sitesPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatarWidget(),
                ],
              ),
              const Expanded(
                child: SizedBox(
                  height: 32,
                ),
              ),
              OutlinedBigButton(
                buttonName: textFiles[language]![19],
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
