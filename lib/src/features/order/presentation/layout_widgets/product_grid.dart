// import 'package:cash_track/src/features/order/domain/product_item.dart';
// import 'package:cash_track/src/features/order/presentation/single_widgets/button_product_custom.dart';
// import 'package:flutter/material.dart';

// class ProductGrid extends StatelessWidget {
//   final List<ProductItem> productItemsList;

//   const ProductGrid({super.key, required this.productItemsList});

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       shrinkWrap: true,
//       itemCount: productItemsList.length,
//       padding: EdgeInsets.zero,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 4,
//         mainAxisSpacing: 20,
//         crossAxisSpacing: 12,
//         mainAxisExtent: 60,
//       ),
//       itemBuilder: (BuildContext context, int index) {
//         ProductItem product = productItemsList[index];
//         return ButtonProductCustom(
//           products: product,
//           onPressed: () {},
//         );
//       },
//     );
//   }
// }

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
            print('${item.productPrice}');
          },
        );
      },
    );
  }
}
