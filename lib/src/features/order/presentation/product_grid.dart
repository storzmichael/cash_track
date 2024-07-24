import 'package:cash_track/src/data/products_list.dart';
import 'package:cash_track/src/features/order/presentation/button_product_custom.dart';
import 'package:flutter/material.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: GridView.builder(
        itemCount: productsData.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 16,
          crossAxisSpacing: 12,
          mainAxisExtent: 60,
        ),
        itemBuilder: (BuildContext context, int index) {
          return ButtonProductCustom(
            products: productsData[index],
            onPressed: () {},
          );
        },
      ),
    );
  }
}
