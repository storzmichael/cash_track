import 'package:cash_track/src/features/events/domain/event_textfield_item.dart';
import 'package:flutter/material.dart';
import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final EventTextfieldItem eventTextfieldItem;
  final TextInputType keyboardType;
  final TextInputFormatter? inputFormatter;

  const CustomTextField({
    super.key,
    this.controller,
    required this.eventTextfieldItem,
    this.keyboardType = TextInputType.text,
    this.inputFormatter,
    required Null Function(dynamic value) onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: greyColor,
        borderRadius: BorderRadius.circular(borderRadiusSmallButton),
      ),
      height: 40,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: textPadding),
        child: Center(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              hintText: eventTextfieldItem.eventTextfieldHintText,
              hintStyle: const TextStyle(color: Colors.white),
              border: InputBorder.none,
              isCollapsed: true,
            ),
            textAlignVertical: TextAlignVertical.center,
          ),
        ),
      ),
    );
  }
}
