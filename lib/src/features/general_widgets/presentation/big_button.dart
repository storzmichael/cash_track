import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final bool fontInBold;
  final EdgeInsetsGeometry padding;
  final int maxLines;

  const BigButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
    this.backgroundColor = primeryColor, // Background color (default: primeryColor)
    this.textColor = Colors.black, // Text color (default: black)
    this.borderRadius = borderRadiusLargeButton, // Rounded corners (default: borderRadiusLargeButton)
    this.fontInBold = true, // Font weight (default: bold)
    this.padding = const EdgeInsets.symmetric(horizontal: 5.0), // Button padding (default: EdgeInsets.all(5.0))
    this.maxLines = 1, // Max number of text lines (default: 1)
  });

  @override
  Widget build(BuildContext context) {
    // Build method that returns the UI widget for the button
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius), // Rounded corners
        ),
        padding: padding, // Button padding
      ),
      child: Center(
        // Text label inside the button
        child: Text(
          buttonName,
          textAlign: TextAlign.center, // Centered text alignment
          maxLines: maxLines, // Limits the text to the specified max lines
          overflow: TextOverflow.ellipsis, // Text overflow behavior
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: textColor, // Text color
                fontWeight: fontInBold ? FontWeight.bold : FontWeight.normal, // Font weight
              ),
        ),
      ),
    );
  }
}
