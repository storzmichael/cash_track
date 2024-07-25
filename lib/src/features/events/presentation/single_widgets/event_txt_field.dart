import 'package:cash_track/src/features/events/domain/event_item.dart';
import 'package:flutter/material.dart';

class EventTxtField extends StatelessWidget {
  final EventItem eventItem;

  const EventTxtField({super.key, required this.eventItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(eventItem.eventTitle),
              Text(eventItem.eventDate),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
