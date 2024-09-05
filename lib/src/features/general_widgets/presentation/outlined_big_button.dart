import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:flutter/material.dart';

class OutlinedBigButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final double borderRadius;
  final double height;
  final double width;
  final bool fontInBold;
  final double borderWidth;
  final int maxLines;

  const OutlinedBigButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
    this.backgroundColor = Colors.transparent,
    this.borderColor = orangeColor,
    this.textColor = Colors.black,
    this.borderRadius = borderRadiusLargeButton,
    this.height = double.infinity,
    this.width = double.infinity,
    this.fontInBold = true,
    this.borderWidth = 3.0,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: BorderSide(color: borderColor, width: borderWidth), // Randfarbe und -dicke
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.all(5),
        ),
        child: Center(
          child: Text(
            buttonName,
            textAlign: TextAlign.center,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: textColor,
                  fontWeight: fontInBold ? FontWeight.bold : FontWeight.normal,
                ),
          ),
        ),
      ),
    );
  }
}
