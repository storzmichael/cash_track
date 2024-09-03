import 'package:cash_track/src/config/config.dart';
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
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: const Text(
          'Neues Event erstellen',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: const Stack(
        children: [
          ThemeContainer(),
          Padding(
            padding: EdgeInsets.all(sitesPadding),
            child: Center(
              child: TextFieldEvent(),
            ),
          ),
        ],
      ),
    );
  }
}
