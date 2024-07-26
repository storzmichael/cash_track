import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/features/order/domain/product_item.dart';
import 'package:flutter/material.dart';

class ButtonProductCustom extends StatelessWidget {
  final ProductItem products;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double height;
  final double width;
  final bool fontInBold;

  const ButtonProductCustom({
    super.key,
    required this.products,
    this.onPressed,
    this.backgroundColor = productColor,
    this.textColor = Colors.black,
    this.borderRadius = borderRadiusSmallButton,
    this.height = 60,
    this.width = 80,
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
            products.productTitle,
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
