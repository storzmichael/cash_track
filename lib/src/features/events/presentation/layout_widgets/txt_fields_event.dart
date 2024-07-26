import 'package:cash_track/src/features/events/application/button_funktions.dart';
import 'package:cash_track/src/features/events/data/event_textfield_data.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:cash_track/src/features/general_widgets/presentation/custom_txt_field.dart';
import 'package:flutter/material.dart';

class TextFieldEvent extends StatelessWidget {
  const TextFieldEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CustomTextField(
            eventTextfieldItem: eventTextfieldDatas[0],
          ),
          const SizedBox(
            height: 12,
          ),
          CustomTextField(
            eventTextfieldItem: eventTextfieldDatas[1],
          ),
          const SizedBox(
            height: 32,
          ),
          CustomTextField(
            eventTextfieldItem: eventTextfieldDatas[2],
          ),
          const SizedBox(
            height: 32,
          ),
          CustomTextField(
            eventTextfieldItem: eventTextfieldDatas[3],
          ),
          const SizedBox(
            height: 12,
          ),
          const BigButton(buttonName: 'Generiere neuen Code'),
          const Expanded(child: SizedBox()),
          BigButton(
            buttonName: 'Erstelle neues Event',
            onPressed: () {
              navigateToEditEventScreen(context);
            },
          ),
        ],
      ),
    );
  }
}
