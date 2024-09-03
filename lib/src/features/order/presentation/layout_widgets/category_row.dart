import 'package:cash_track/src/features/order/presentation/single_widgets/button_category_custom.dart';
import 'package:flutter/material.dart';

class CategoryRow extends StatelessWidget {
  final Map<String, dynamic> categories;

  const CategoryRow({
    super.key,
    required this.categories,
  });
  @override
  Widget build(BuildContext context) {
    List<String> keys = categories.keys.toList();
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: keys.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ButtonCategoryCustom(
              categoryTitle: keys[index],
              fontInBold: true,
            ));
      },
    );
  }
}
