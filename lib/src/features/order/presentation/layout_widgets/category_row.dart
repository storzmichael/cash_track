import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/order/application/order_provider.dart';
import 'package:cash_track/src/features/order/domain/product_item.dart';
import 'package:cash_track/src/features/order/presentation/layout_widgets/product_grid.dart';
import 'package:cash_track/src/features/order/presentation/single_widgets/button_category_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryRow extends StatelessWidget {
  final Map<String, List<ProductItem>> category;

  CategoryRow({
    super.key,
    required this.category,
  });

  // Speichert den Schlüssel der ausgewählten Kategorie
  final double gridHeight = 315;
  // Höhe des Produkt-Grid

  @override
  Widget build(BuildContext context) {
    List<String> keys = category.keys.toList(); // Liste der Kategorienamen
    return Column(
      children: [
        // Horizontale Liste der Kategorien als Buttons
        SizedBox(
          height: bigBttnHeight, // Höhe der Buttons
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // Horizontales Scrollen
            itemCount: keys.length, // Anzahl der Kategorien
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: smallPadding),
                child: Consumer<OrderProvider>(
                  builder: (context, orderProvider, child) {
                    return ButtonCategoryCustom(
                      categoryTitle: keys[index], // Titel der Kategorie
                      fontInBold: true, // Schrift fett
                      onPressed: () {
                        orderProvider.setCategory(keys[index]); // Kategorie auswählen
                        orderProvider.setTableSelect(true);
                        // ignore: avoid_print
                        print('category gedrückt'); // Ausgabe beim Drücken eines Buttons
                      },
                    );
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
              height: 24, // Abstand zwischen der Kategorieauswahl und dem Grid
            ),
            SizedBox(
              height: gridHeight, // Höhe des Grids
              child: Padding(
                padding: const EdgeInsets.all(4.0), // Innenabstand des Grids
                child: Consumer<OrderProvider>(builder: (context, orderProvider, child) {
                  return selectCategory(orderProvider.selectedCategoryKey);
                }), // Anzeige der Produkte basierend auf der ausgewählten Kategorie
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Methode zum Auswählen der Kategorie und Anzeige der entsprechenden Produkte
  Widget selectCategory(String? categoryKey) {
    // Wenn keine Kategorie ausgewählt wurde
    if (categoryKey == null) {
      return Text(textFiles[language]![7]); // Zeigt einen Standardtext an
    }

    List<ProductItem>? items = category[categoryKey]; // Produkte der ausgewählten Kategorie

    // Wenn die Kategorie leer oder nicht vorhanden ist
    if (items == null || items.isEmpty) {
      return Text(textFiles[language]![8]); // Zeigt an, dass keine Produkte vorhanden sind
    }

    // Anzeige des Produktgrids mit den ausgewählten Produkten
    return ProductGrid(
      productItemsList: items,
    );
  }
}
