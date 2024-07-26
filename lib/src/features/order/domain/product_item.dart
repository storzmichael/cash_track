import 'package:flutter/material.dart';

class ProductItem {
  final String productTitle;
  final double productPrice;
  final Function(BuildContext) productOnPressed;

  const ProductItem({
    required this.productTitle,
    required this.productPrice,
    required this.productOnPressed,
  });
}
