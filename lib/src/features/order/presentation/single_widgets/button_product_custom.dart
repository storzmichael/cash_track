import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/features/order/domain/product_item.dart';
import 'package:flutter/material.dart';

class ButtonProductCustom extends StatelessWidget {
  final ProductItem productItem;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double height;
  final double width;
  final bool fontInBold;
  final int maxLines;

  const ButtonProductCustom({
    super.key,
    required this.productItem,
    required this.onPressed,
    this.backgroundColor = productColor,
    this.textColor = Colors.black,
    this.borderRadius = borderRadiusSmallButton,
    this.height = 60,
    this.width = 80,
    this.fontInBold = false,
    this.maxLines = 2,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.all(5),
        ),
        child: Center(
          child: Text(
            productItem.productTitle,
            textAlign: TextAlign.center,
            maxLines: maxLines,
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
