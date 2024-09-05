import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/features/order/data/order_data_map.dart';
import 'package:cash_track/src/features/order/presentation/single_widgets/button_product_custom.dart';
import 'package:flutter/material.dart';
import 'package:cash_track/src/features/order/domain/product_item.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductItem> productItemsList;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  const ProductGrid({
    super.key,
    required this.productItemsList,
    this.crossAxisCount = 4,
    this.crossAxisSpacing = 10,
    this.mainAxisSpacing = 20,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
      ),
      itemCount: productItemsList.length,
      itemBuilder: (context, index) {
        final item = productItemsList[index];
        return ButtonProductCustom(
          productItem: item,
          onPressed: () {
            orderData[deskNumber] = ProductItem(
                productTitle: item.productTitle,
                productPrice: item.productPrice,
                productCategory: item.productCategory);
            print('${item.productPrice}');
            print('${item.productTitle}');
            print(orderData);
          },
        );
      },
    );
  }
}
