import 'package:cash_track/src/core/presentation/theme_container.dart';
import 'package:cash_track/src/features/events/presentation/layout_widgets/event_grid.dart';
import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        ThemeContainer(),
        Padding(
          padding: EdgeInsets.fromLTRB(40.0, 32.0, 40.0, 32.0),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 150,
                      width: 320,
                      child: Image(
                        image: AssetImage('assets/logo/logo.png'),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Text(
                      'CashTrack',
                      style: TextStyle(fontFamily: 'RubikOne', fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Einfach Smart Kassieren',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32,
              ),
              EventGrid(),
            ],
          ),
        ),
      ],
    );
  }
}
