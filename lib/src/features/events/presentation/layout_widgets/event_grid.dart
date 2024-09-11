import 'package:flutter/material.dart';
import 'package:cash_track/src/features/events/data/event_button_data.dart';
import 'package:cash_track/src/features/events/presentation/single_widgets/event_button.dart';

class EventGrid extends StatelessWidget {
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double mainAxisExtent;

  const EventGrid({
    super.key,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 32,
    this.crossAxisSpacing = 32,
    this.mainAxisExtent = 140,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 312,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: eventButtonDatas.length,
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisExtent: mainAxisExtent,
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
