import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/core/presentation/theme_container.dart';
import 'package:cash_track/src/features/events/presentation/layout_widgets/txt_fields_event.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateEventScreen extends StatelessWidget {
  const CreateEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightThemeColorLight,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        automaticallyImplyLeading: false, // Entfernt das Chevron-Symbol
        title: Text(
          textFiles[language]![42],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, "/settings");
            },
          ),
        ],
      ),
      body: const Stack(
        children: [
          ThemeContainer(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(sitesPadding),
              child: Center(
                child: TextFieldEvent(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
