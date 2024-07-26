import 'package:flutter/material.dart';

class EventButtonItem {
  final String eventButtonTitle;
  final IconData eventButtonIcon;
  final Function(BuildContext) eventButtonOnPressed;

  const EventButtonItem({
    required this.eventButtonTitle,
    required this.eventButtonIcon,
    required this.eventButtonOnPressed,
  });
}
