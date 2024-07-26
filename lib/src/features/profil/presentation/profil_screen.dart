import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/core/presentation/theme_container.dart';
import 'package:cash_track/src/features/general_widgets/presentation/outlined_big_button.dart';
import 'package:cash_track/src/features/profil/presentation/circle_avatar_widget.dart';

import 'package:flutter/material.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        ThemeContainer(),
        Padding(
          padding: EdgeInsets.all(sitesPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatarWidget(),
                ],
              ),
              Expanded(
                child: SizedBox(
                  height: 32,
                ),
              ),
              OutlinedBigButton(
                buttonName: 'Profil ändern',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
