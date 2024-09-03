import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/features/events/data/event_data.dart';

import 'package:cash_track/src/features/events/presentation/single_widgets/event_txt_field.dart';
import 'package:flutter/material.dart';

class EventList extends StatelessWidget {
  const EventList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: greyColor,
          borderRadius: BorderRadius.circular(borderRadiusSmallButton),
        ),
        child: ListView.builder(
          itemCount: eventDatas.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return EventTxtField(
              eventItem: eventDatas[index],
            );
          },
        ),
      ),
    );
  }
}
