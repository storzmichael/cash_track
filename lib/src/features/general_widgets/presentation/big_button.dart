import 'package:cash_track/src/config/config_colors.dart';
import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;

  final bool fontInBold;

  const BigButton({
    super.key,
    required this.buttonName,
    this.onPressed,
    this.backgroundColor = orangeColor,
    this.textColor = Colors.black,
    this.borderRadius = 20,
    this.fontInBold = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed ?? () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: const EdgeInsets.all(5),
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
