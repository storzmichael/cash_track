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

  const BigButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
    this.backgroundColor = orangeColor,
    this.textColor = Colors.black,
    this.borderRadius = borderRadiusLargeButton,
    this.fontInBold = true,
    this.padding = const EdgeInsets.all(5.0),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: padding,
      ),
      child: Center(
        child: Text(
          buttonName,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: textColor,
                fontWeight: fontInBold ? FontWeight.bold : FontWeight.normal,
              ),
        ),
      ),
    );
  }
}
