import 'package:cash_track/src/features/order/data/products_list.dart';
import 'package:cash_track/src/features/order/domain/product_item.dart';
import 'package:cash_track/src/features/order/presentation/single_widgets/button_product_custom.dart';
import 'package:flutter/material.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductItem> productsBttnList;

  const ProductGrid({super.key, required this.productsBttnList});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: productsBttnList.length,
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 20,
        crossAxisSpacing: 12,
        mainAxisExtent: 60,
      ),
      itemBuilder: (BuildContext context, int index) {
        return ButtonProductCustom(
          products: productsBttnList[index],
          onPressed: () {},
        );
      },
    );
  }
}
