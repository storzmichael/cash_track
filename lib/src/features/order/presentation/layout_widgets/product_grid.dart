import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/features/order/data/order_data_map.dart';
import 'package:cash_track/src/features/order/presentation/single_widgets/button_product_custom.dart';
import 'package:flutter/material.dart';
import 'package:cash_track/src/features/order/domain/product_item.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductItem> productItemsList;

  const ProductGrid({
    super.key,
    required this.productItemsList,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
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
