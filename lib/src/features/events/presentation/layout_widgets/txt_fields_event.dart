import 'package:cash_track/src/features/events/application/button_funktions.dart';
import 'package:cash_track/src/features/events/data/event_textfield_data.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:cash_track/src/features/general_widgets/presentation/custom_txt_field.dart';
import 'package:flutter/material.dart';

class TextFieldEvent extends StatefulWidget {
  const TextFieldEvent({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TextFieldEventState createState() => _TextFieldEventState();
}

class _TextFieldEventState extends State<TextFieldEvent> {
  final TextEditingController _lastTextFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CustomTextField(
            eventTextfieldItem: eventTextfieldDatas[0],
            controller: null,
            onChanged: (value) {},
          ),
          const SizedBox(
            height: 12,
          ),
          CustomTextField(
            eventTextfieldItem: eventTextfieldDatas[1],
            onChanged: (value) {},
          ),
          const SizedBox(
            height: 32,
          ),
          CustomTextField(
            eventTextfieldItem: eventTextfieldDatas[2],
            onChanged: (value) {},
          ),
          const SizedBox(
            height: 32,
          ),
          CustomTextField(
            eventTextfieldItem: eventTextfieldDatas[3],
            controller: _lastTextFieldController,
            onChanged: (value) {},
          ),
          const SizedBox(
            height: 12,
          ),
          BigButton(
            buttonName: 'Generiere neuen Code',
            onPressed: () {
              setState(() {
                String newCode = generateRandomCode(8);
                _lastTextFieldController.text = newCode;
              });
            },
          ),
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
