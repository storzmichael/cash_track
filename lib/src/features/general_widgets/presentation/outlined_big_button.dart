import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:flutter/material.dart';

class OutlinedBigButton extends StatelessWidget {
  final String buttonName; // Label text for the button
  final VoidCallback onPressed; // Callback function when button is pressed
  final Color backgroundColor; // Background color (default: transparent)
  final Color borderColor; // Border color (default: primeryColor)
  final Color textColor; // Text color (default: black)
  final double borderRadius; // Rounded corners (default: borderRadiusLargeButton)
  final double height; // Button height (default: double.infinity)
  final double width; // Button width (default: double.infinity)
  final bool fontInBold; // Font style (bold or normal, default: bold)
  final double borderWidth; // Border width (default: 2.0)
  final int maxLines; // Max number of text lines (default: 1)

  const OutlinedBigButton({
    super.key,
    required this.buttonName, // Required button label
    required this.onPressed, // Required press callback
    this.backgroundColor = Colors.transparent, // Default background
    this.borderColor = primeryColor, // Default border color
    this.textColor = Colors.black, // Default text color
    this.borderRadius = borderRadiusLargeButton, // Default border radius
    this.height = double.infinity, // Default height
    this.width = double.infinity, // Default width
    this.fontInBold = true, // Default bold font
    this.borderWidth = 2.0, // Default border width
    this.maxLines = 1, // Default max lines
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height, // Set button height
      width: width, // Set button width
      child: OutlinedButton(
        onPressed: onPressed, // Button action
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor, // Set background color
          side: BorderSide(color: borderColor, width: borderWidth), // Border color and width
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius), // Rounded corners
          ),
          padding: const EdgeInsets.all(5), // Button padding
        ),
        child: Center(
          child: Text(
            buttonName, // Button label text
            textAlign: TextAlign.center, // Center the text
            maxLines: maxLines, // Limit number of lines
            overflow: TextOverflow.ellipsis, // Handle text overflow
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: textColor, // Text color
                  fontWeight: fontInBold ? FontWeight.bold : FontWeight.normal, // Font weight
                ),
          ),
        ),
      ),
    );
  }
}
