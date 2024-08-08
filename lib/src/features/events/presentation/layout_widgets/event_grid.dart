import 'package:flutter/material.dart';
import 'package:cash_track/src/features/events/data/event_button_data.dart';
import 'package:cash_track/src/features/events/presentation/single_widgets/event_button.dart';

class EventGrid extends StatelessWidget {
  const EventGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 312,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: eventButtonDatas.length,
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 32,
          crossAxisSpacing: 32,
          mainAxisExtent: 140,
        ),
        itemBuilder: (BuildContext context, int index) {
          return EventButton(
            eventButtonItem: eventButtonDatas[index],
          );
        },
      ),
    );
  }
}
