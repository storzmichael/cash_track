import 'package:cash_track/src/features/order/data/products_list.dart';
import 'package:cash_track/src/features/order/presentation/single_widgets/button_product_custom.dart';
import 'package:flutter/material.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: productsData.length,
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 20,
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
