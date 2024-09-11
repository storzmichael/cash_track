import 'package:cash_track/src/features/events/domain/event_textfield_item.dart';
import 'package:flutter/material.dart';
import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
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

  // Constructor for initializing CustomTextField widget
  const CustomTextField({
    super.key, // Key for widget identification
    this.controller, // Text controller (optional)
    required this.eventTextfieldItem, // Required object for hint text and other properties
    this.keyboardType = TextInputType.text, // Default keyboard type is text
    this.inputFormatter, // Optional input formatter for validation
    required Null Function(dynamic value) onChanged, // Function to handle text change
  });

  @override
  Widget build(BuildContext context) {
    // Main widget build method that returns a customized text field
    return Container(
      decoration: BoxDecoration(
        color: textFieldColor, // Background color for the text field
        borderRadius: BorderRadius.circular(borderRadiusSmallButton), // Rounded corners
      ),
      height: textFieldheight, // Fixed height for the text field
      width: double.infinity, // Full width of the parent container
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: textPadding), // Horizontal padding
        child: Center(
          child: TextFormField(
            controller: controller, // Links the controller to the text field
            decoration: InputDecoration(
              labelStyle: const TextStyle(fontWeight: FontWeight.bold), // Bold label text style
              hintText: eventTextfieldItem.eventTextfieldHintText, // Hint text from eventTextfieldItem
              hintStyle: const TextStyle(color: Colors.white), // Hint text color
              border: InputBorder.none, // No border style for the text field
              isCollapsed: true, // Collapses the field's internal padding
            ),
            textAlignVertical: TextAlignVertical.center, // Centers the text vertically
          ),
        ),
      ),
    );
  }
}
