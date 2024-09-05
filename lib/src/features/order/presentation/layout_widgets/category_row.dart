import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/order/domain/product_item.dart';
import 'package:cash_track/src/features/order/presentation/layout_widgets/product_grid.dart';
import 'package:cash_track/src/features/order/presentation/single_widgets/button_category_custom.dart';
import 'package:flutter/material.dart';

class CategoryRow extends StatefulWidget {
  final Map<String, List<ProductItem>> category;

  // ignore: prefer_typing_uninitialized_variables
  static var setCategory;

  const CategoryRow({
    super.key,
    required this.category,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CategoryRowState createState() => _CategoryRowState();
}

class _CategoryRowState extends State<CategoryRow> {
  String? selectedCategoryKey;
  final double gridHeight = 320;

  void setCategory(String categoryKey) {
    setState(() {
      selectedCategoryKey = categoryKey;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> keys = widget.category.keys.toList();
    return Column(
      children: [
        SizedBox(
          height: bigBttnHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: keys.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: smallPadding),
                child: ButtonCategoryCustom(
                  categoryTitle: keys[index],
                  fontInBold: true,
                  onPressed: () {
                    setCategory(keys[index]);
                    print('category gedrückt');
                  },
                ),
              );
            },
          ),
        ),
        // Anzeige des Widgets basierend auf der ausgewählten Kategorie
        Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              height: gridHeight,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: selectCategory(selectedCategoryKey),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget selectCategory(String? categoryKey) {
    if (categoryKey == null) {
      return Text(textFiles[language]![7]);
    }

    List<ProductItem>? items = widget.category[categoryKey];

    if (items == null || items.isEmpty) {
      return Text(textFiles[language]![8]);
    }

    return ProductGrid(
      productItemsList: items,
    );
  }
}
