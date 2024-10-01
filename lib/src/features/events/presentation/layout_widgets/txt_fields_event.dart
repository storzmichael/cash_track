import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
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
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _ceatorController = TextEditingController();

  Widget _generateCodeButton() {
    return BigButton(
      buttonName: textFiles[language]![43],
      onPressed: () {
        setState(() {
          String newCode = generateRandomCode(8);
          _codeController.text = newCode;
        });
      },
    );
  }

  Widget _createEventButton() {
    return BigButton(
      buttonName: textFiles[language]![44],
      onPressed: () {
        Navigator.pushReplacementNamed(context, "/createProducts");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Event Name:
        CustomTextField(
          eventTextfieldItem: eventTextfieldDatas[0],
          controller: _eventNameController,
          onChanged: (value) {},
        ),
        const SizedBox(
          height: 12,
        ),

        // Ersteller
        CustomTextField(
          eventTextfieldItem: eventTextfieldDatas[2],
          controller: _ceatorController,
          onChanged: (value) {},
        ),
        const SizedBox(
          height: 32,
        ),

        // Code
        CustomTextField(
          eventTextfieldItem: eventTextfieldDatas[3],
          controller: _codeController,
          onChanged: (value) {},
        ),
        const SizedBox(
          height: 12,
        ),

        //Generiere neuen Code
        _generateCodeButton(),
        const Expanded(child: SizedBox()),

        // Erstelle neues Event
        _createEventButton(),
        SizedBox(
          height: bottomSafeArea,
        ),
      ],
    );
  }
}
