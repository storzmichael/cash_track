import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/features/events/domain/event_textfield_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  // Controller for managing the text input
  final TextEditingController? controller;

  // Custom object that holds text field configuration
  final EventTextfieldItem eventTextfieldItem;

  // Defines the keyboard type for input (default is text)
  final TextInputType keyboardType;

  // Optional input formatter for restricting input (e.g., digits only)
  final TextInputFormatter? inputFormatter;

  // Function to handle text change
  final void Function(String)? onChanged; // Hier hinzugefügt

  // Constructor for initializing CustomTextField widget
  const CustomTextField({
    super.key,
    this.controller,
    required this.eventTextfieldItem,
    this.keyboardType = TextInputType.text,
    this.inputFormatter,
    this.onChanged, // Hier hinzugefügt
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: textFieldColor,
        borderRadius: BorderRadius.circular(borderRadiusSmallButton),
      ),
      height: textFieldheight,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: textPadding),
        child: Center(
          child: TextFormField(
            autofocus: true,
            controller: controller,
            keyboardType: keyboardType, // Keyboard type verwenden
            inputFormatters: inputFormatter != null ? [inputFormatter!] : null,
            decoration: InputDecoration(
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              hintText: eventTextfieldItem.eventTextfieldHintText,
              hintStyle: const TextStyle(color: Colors.white),
              border: InputBorder.none,
              isCollapsed: true,
            ),
            textAlignVertical: TextAlignVertical.center,
            onChanged: onChanged, // onChanged-Callback hier hinzugefügt
          ),
        ),
      ),
    );
  }
}
