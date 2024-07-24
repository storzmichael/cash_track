import 'package:cash_track/src/features/events/data/event_button_data.dart';
import 'package:cash_track/src/features/events/presentation/event_button.dart';
import 'package:flutter/material.dart';

class EventGrid extends StatelessWidget {
  const EventGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 430,
      child: GridView.builder(
        shrinkWrap: false,
        itemCount: eventButtonData.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 32,
          crossAxisSpacing: 32,
          mainAxisExtent: 140,
        ),
        itemBuilder: (BuildContext context, int index) {
          return EventButton(
            eventButtonItem: eventButtonData[index],
            onPressed: () {},
          );
        },
      ),
    );
  }
}
