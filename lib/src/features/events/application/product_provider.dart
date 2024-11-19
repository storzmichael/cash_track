import 'dart:developer';

import 'package:cash_track/src/features/order/domain/product_item.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  List<String> categories = [];
  String? toCategory;

  // Variable zur Speicherung der ausgewählten Kategorie (Index)
  int? _selectedCategory;

  // Getter für die ausgewählte Kategorie
  int? get selectedCategory => _selectedCategory;

  // Methode zum Setzen der ausgewählten Kategorie
  void setSelectedCategory(int index) {
    _selectedCategory = index;
    notifyListeners(); // Benachrichtige über Änderungen
  }

  // Map, die Kategorien mit einer Liste von ProductItems verknüpft
  Map<String, List<ProductItem>> _categoryProductMap = {};

  // Getter für die Kategorie-Produkt-Map
  Map<String, List<ProductItem>> get categoryProductMap => _categoryProductMap;

  // Methode zum Löschen einer Kategorie
  void deleteCategory(int index) {
    if (index >= 0 && index < categories.length) {
      String categoryToDelete = categories[index];

      categories.removeAt(index);

      categoryProductMap.remove(categoryToDelete);

      notifyListeners();
    }
  }

  // Methode zum Hinzufügen einer neuen Kategorie
  void addCategory(String category) {
    if (!categories.contains(category)) {
      categories.add(category);
      // Erstelle eine neue Liste für die Kategorie
      categoryProductMap[category] = [
        ProductItem(productTitle: '', productPrice: 0),
        ProductItem(productTitle: '', productPrice: 0),
        ProductItem(productTitle: '', productPrice: 0),
        ProductItem(productTitle: '', productPrice: 0),
        ProductItem(productTitle: '', productPrice: 0),
        ProductItem(productTitle: '', productPrice: 0),
        ProductItem(productTitle: '', productPrice: 0),
        ProductItem(productTitle: '', productPrice: 0),
        ProductItem(productTitle: '', productPrice: 0),
        ProductItem(productTitle: '', productPrice: 0),
        ProductItem(productTitle: '', productPrice: 0),
        ProductItem(productTitle: '', productPrice: 0),
      ];

      notifyListeners();
    }
  }

  void updateProductItem(String category, int index, ProductItem updatedProduct) {
    // Prüfen, ob die Kategorie in der Map vorhanden ist und der Index gültig ist
    if (categoryProductMap.containsKey(category) && index >= 0 && index < categoryProductMap[category]!.length) {
      // Überschreiben des Produktes an der gegebenen Position
      categoryProductMap[category]![index] = updatedProduct;

      // Benachrichtige alle Zuhörer über die Statusänderung
      notifyListeners();
    } else {
      // Kategorie oder Index ist ungültig
      print('Kategorie oder Index ungültig');
    }
  }

  //-----------------------------------------------------------------

  // Funktion zum Hinzufügen eines Produkts in die Liste der Map
  void addProductToCategory(String category, ProductItem product) {
    // Prüfen, ob die Kategorie bereits existiert
    if (!_categoryProductMap.containsKey(category)) {
      // Wenn nicht, erstelle eine neue Liste für diese Kategorie
      _categoryProductMap[category] = [];
    }
    // Füge das Produkt zur Kategorie hinzu
    _categoryProductMap[category]!.add(product);
    log(categoryProductMap.toString());

    // Benachrichtige die UI über Änderungen
    notifyListeners();
  }

  // Funktion zum Speichern aller Produkte einer bestimmten Kategorie
  void saveProductsInCategory(String category, List<ProductItem> products) {
    // Überprüfen, ob die Kategorie bereits existiert
    if (!_categoryProductMap.containsKey(category)) {
      // Wenn nicht, erstelle eine neue Liste für diese Kategorie
      _categoryProductMap[category] = [];
    }

    // Füge alle Produkte zur Kategorie hinzu
    _categoryProductMap[category]!.addAll(products);

    // Benachrichtige die UI über Änderungen
    notifyListeners();
  }

  //------------------------------------------------------------------

  // Die Map zur Speicherung der Produktkategorien und -artikel
  // Map<String, List> categoryData = {
  //   'Getränke': [
  //     ProductItem(
  //       productTitle: 'Cola',
  //       productPrice: 3.00,
  //     ),
  //     ProductItem(
  //       productTitle: 'Fanta',
  //       productPrice: 3.00,
  //     ),
  //     ProductItem(
  //       productTitle: 'Wasser',
  //       productPrice: 2.50,
  //     ),
  //     ProductItem(
  //       productTitle: 'Wein',
  //       productPrice: 3.50,
  //     ),
  //     ProductItem(
  //       productTitle: 'Bier',
  //       productPrice: 4.00,
  //     ),
  //   ],
  //   'Essen': [
  //     ProductItem(
  //       productTitle: 'Pommes',
  //       productPrice: 4.00,
  //     ),
  //     ProductItem(
  //       productTitle: 'Grillwurst',
  //       productPrice: 4.00,
  //     ),
  //     ProductItem(
  //       productTitle: 'Salat',
  //       productPrice: 4.00,
  //     ),
  //   ]
  // };

  // Methode zur Benachrichtigung über Änderungen
  void notify() {
    notifyListeners();
  }

  // Methode zum Entsorgen der TextEditingController
  void disposeControllers() {
    nameController.dispose();
    priceController.dispose();
    categoryController.dispose();
  }

  // Methode zum Entfernen eines Produkts
  // void removeProduct(String category, ProductItem product) {
  //   if (categoryData.containsKey(category)) {
  //     categoryData[category]!.remove(product);
  //     if (categoryData[category]!.isEmpty) {
  //       categoryData.remove(category);
  //     }
  //     notify();
  //   }
  // }
}
