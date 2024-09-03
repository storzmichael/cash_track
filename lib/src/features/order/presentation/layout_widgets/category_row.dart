import 'package:cash_track/src/features/order/domain/product_item.dart';
import 'package:cash_track/src/features/order/presentation/layout_widgets/product_grid.dart';
import 'package:cash_track/src/features/order/presentation/single_widgets/button_category_custom.dart';
import 'package:flutter/material.dart';

class CategoryRow extends StatefulWidget {
  final Map<String, List<ProductItem>> category;

  static var setCategory;

  const CategoryRow({
    super.key,
    required this.category,
  });

  @override
  _CategoryRowState createState() => _CategoryRowState();
}

class _CategoryRowState extends State<CategoryRow> {
  String? selectedCategoryKey;

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
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: keys.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
            SizedBox(
              height: 24,
            ),
            Container(
              //color: Colors.grey,
              height: 275,
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
      return const Text('Bitte erstelle eine Kategorie.');
    }

    List<ProductItem>? items = widget.category[categoryKey];

    if (items == null || items.isEmpty) {
      return const Text('Keine Elemente in dieser Kategorie.');
    }

    return ProductGrid(
      productItemsList: items,
    );
  }
}
