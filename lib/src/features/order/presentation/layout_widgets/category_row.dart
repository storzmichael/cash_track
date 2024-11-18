import 'dart:developer';

import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/events/application/product_provider.dart';
import 'package:cash_track/src/features/events/presentation/screens/create_product_screen.dart.dart';
import 'package:cash_track/src/features/order/application/order_provider.dart';
import 'package:cash_track/src/features/order/domain/product_item.dart';
import 'package:cash_track/src/features/order/presentation/layout_widgets/edit_product_grid.dart';
import 'package:cash_track/src/features/order/presentation/layout_widgets/product_grid.dart';
import 'package:cash_track/src/features/order/presentation/single_widgets/button_category_custom.dart';
import 'package:cash_track/src/features/settings/application/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryRow extends StatelessWidget {
  final List<String> categories; // Liste der Kategorien
  final List<ProductItem> products; // Liste der Produkte

  const CategoryRow({
    super.key,
    required this.categories,
    this.products = const [],
  });

  final double gridHeight = 315; // Höhe des Produkt-Grid

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);
    return Column(
      children: [
        // Horizontale Liste der Kategorien als Buttons
        SizedBox(
          height: bigBttnHeight, // Höhe der Buttons
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // Horizontales Scrollen
            itemCount: categories.length, // Anzahl der Kategorien
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: smallPadding),
                child: isInEditing
                    ? ButtonCategoryCustom(
                        categoryTitle: categories[index], // Titel der Kategorie
                        fontInBold: true, // Schrift fett
                        backgroundColor: productProvider.selectedCategory == index
                            ? greenColor // Farbe für ausgewählte Kategorie
                            : greyColor, // Standardfarbe
                        onPressed: () {
                          productProvider.setSelectedCategory(index);
                          productProvider.toCategory = categories[index]; // Setze die ausgewählte Kategorie im Provider
                          print(productProvider.categories[index]);
                          print(productProvider.toCategory);
                        },
                        onLongPressed: () async {
                          await orderProvider.showDeleteCategoryDialog(context, productProvider, index);
                        },
                      )
                    : ButtonCategoryCustom(
                        categoryTitle: categories[index], // Titel der Kategorie
                        fontInBold: true, // Schrift fett
                        backgroundColor: productProvider.selectedCategory == index
                            ? greenColor // Farbe für ausgewählte Kategorie
                            : greyColor, // Standardfarbe
                        onPressed: () {
                          productProvider.setSelectedCategory(index);
                          productProvider.toCategory =
                              productProvider.categories[index]; // Setze die ausgewählte Kategorie im Provider
                          log(productProvider.categoryProductMap.toString());
                          log(productProvider.toCategory ?? 'Default Category');
                        },
                      ),
              );
            },
          ),
        ),
        const SizedBox(height: 24), // Abstand zwischen der Kategorieauswahl und dem Grid

        // Anzeige des Widgets basierend auf der Bearbeitungsmodus-Flagge
        SizedBox(
          height: gridHeight, // Höhe des Grids
          child: Padding(
            padding: const EdgeInsets.all(4.0), // Innenabstand des Grids
            child: Consumer<ProductProvider>(
              builder: (context, productProvider, child) {
                final selectedIndex = productProvider.selectedCategory;
                // Wähle je nach `isInEditing` den entsprechenden Grid-Typ aus
                return isInEditing
                    ? _editCategory(context, selectedIndex, languageProvider, productProvider) // Im Bearbeitungsmodus
                    : _selectCategory(
                        context, selectedIndex, languageProvider, productProvider, orderProvider); // Im Bestellmodus
              },
            ),
          ),
        ),
      ],
    );
  }

  // Methode zum Anzeigen der Produkte im Bestellmodus
  Widget _selectCategory(BuildContext context, int? selectedIndex, LanguageProvider languageProvider,
      ProductProvider productProvider, OrderProvider orderProvider) {
    // Wenn keine Kategorie ausgewählt wurde
    if (selectedIndex == null) {
      return Text(textFiles[languageProvider.language]![7]); // Zeigt einen Standardtext an
    }

    // Holen der Produktliste der ausgewählten Kategorie
    String category = productProvider.categories[selectedIndex];
    List<ProductItem> items = productProvider.categoryProductMap[category] ?? [];

    if (items.isEmpty) {
      return Text(textFiles[languageProvider.language]![8]); // Zeigt an, dass keine Produkte vorhanden sind
    }

    // Verwende `ProductGrid` für den Bestellprozess
    return ProductGrid(
      productItemsList: items, // Übergib die Liste der ProductItem-Objekte
      onPressed: (productItem) {
        print('onpressed aufgerufen');
        orderProvider.addToSelect(productItem, context);
        print("Produkt ausgewählt: ${productItem.toString()}");
        log('selectedProducts:${orderProvider.selectedProducts.toString()}');
      },
    );
  }

  // Methode zum Anzeigen der Produkte im Bearbeitungsmodus
  Widget _editCategory(
      BuildContext context, int? selectedIndex, LanguageProvider languageProvider, ProductProvider productProvider) {
    // Wenn keine Kategorie ausgewählt wurde
    if (selectedIndex == null) {
      return Text(textFiles[languageProvider.language]![7]); // Zeigt einen Standardtext an
    }

    // Holen der Produktliste der ausgewählten Kategorie
    String category = productProvider.categories[selectedIndex];
    List<ProductItem> items = productProvider.categoryProductMap[category] ?? [];

    if (items.isEmpty) {
      return Text(textFiles[languageProvider.language]![8]); // Zeigt an, dass keine Produkte vorhanden sind
    }

    // Verwende `EditProductGrid` für den Bearbeitungsprozess
    return EditProductGrid(
      productItemsList: items, // Richtiges Zuweisen der Produktliste
      onPressed: (productItem) {
        // Navigation zu CreateProductScreen mit index und productItem
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateProductScreen(
              index: items.indexOf(productItem), // Übergabe des Index
              product: productItem, // Übergabe des Produkts
            ),
          ),
        );
      },
    );
  }
}
