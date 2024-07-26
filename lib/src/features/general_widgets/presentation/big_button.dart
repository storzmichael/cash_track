import 'package:cash_track/src/config/config_colors.dart';

import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  final String buttonName;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double height;
  final double width;
  final bool fontInBold;

  const BigButton({
    super.key,
    required this.buttonName,
    this.backgroundColor = orangeColor,
    this.textColor = Colors.black,
    this.borderRadius = 20,
    this.height = 40,
    this.width = double.infinity,
    this.fontInBold = true,
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
            buttonName,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
    );
  }
}
