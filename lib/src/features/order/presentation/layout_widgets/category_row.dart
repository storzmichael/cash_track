import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/order/domain/product_item.dart';
import 'package:cash_track/src/features/order/presentation/layout_widgets/product_grid.dart';
import 'package:cash_track/src/features/order/presentation/single_widgets/button_category_custom.dart';
import 'package:flutter/material.dart';

class CategoryRow extends StatefulWidget {
  final Map<String, List<ProductItem>> category;

  // Variable zum Setzen der Kategorie (ignoriert den Typ-Vorschlag)
  // ignore: prefer_typing_uninitialized_variables
  static var setCategory;

  const CategoryRow({
    super.key,
    required this.category,
  });

  @override
  // Zustand für CategoryRow erstellen
  // ignore: library_private_types_in_public_api
  _CategoryRowState createState() => _CategoryRowState();
}

class _CategoryRowState extends State<CategoryRow> {
  String? selectedCategoryKey; // Speichert den Schlüssel der ausgewählten Kategorie
  final double gridHeight = 315; // Höhe des Produkt-Grid

  // Methode zum Setzen der ausgewählten Kategorie
  void setCategory(String categoryKey) {
    setState(() {
      selectedCategoryKey = categoryKey;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> keys = widget.category.keys.toList(); // Liste der Kategorienamen
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
                child: ButtonCategoryCustom(
                  categoryTitle: keys[index], // Titel der Kategorie
                  fontInBold: true, // Schrift fett
                  onPressed: () {
                    setCategory(keys[index]); // Kategorie auswählen
                    print('category gedrückt'); // Ausgabe beim Drücken eines Buttons
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
                child: selectCategory(
                    selectedCategoryKey), // Anzeige der Produkte basierend auf der ausgewählten Kategorie
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

    List<ProductItem>? items = widget.category[categoryKey]; // Produkte der ausgewählten Kategorie

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
