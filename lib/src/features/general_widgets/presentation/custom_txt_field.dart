import 'package:cash_track/src/features/events/domain/event_textfield_item.dart';
import 'package:flutter/material.dart';
import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';

class CustomTextField extends StatelessWidget {
  final EventTextfieldItem eventTextfieldItem;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.eventTextfieldItem,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: textFieldColor,
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
