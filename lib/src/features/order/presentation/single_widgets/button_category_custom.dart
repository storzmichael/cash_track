import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:flutter/material.dart';

class ButtonCategoryCustom extends StatelessWidget {
  final String categoryTitle;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double height;
  final double width;
  final bool fontInBold;

  const ButtonCategoryCustom({
    super.key,
    required this.categoryTitle,
    this.onPressed,
    this.backgroundColor = greenColor,
    this.textColor = Colors.white,
    this.borderRadius = borderRadiusSmallButton,
    this.height = double.infinity,
    this.width = 104,
    this.fontInBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.all(5),
        ),
        child: Center(
          child: Text(
            categoryTitle,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: textColor,
                  fontWeight: fontInBold ? FontWeight.bold : FontWeight.normal,
                ),
          ),
        ),
      ),
    );
  }
}
