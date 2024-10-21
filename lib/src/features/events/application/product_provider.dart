import 'package:cash_track/src/features/order/domain/product_item.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  // Die Map zur Speicherung der Produktkategorien und -artikel
  Map<String, List> categoryData1 = {};

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

  // Methode zum Hinzufügen eines Produkts
  void addProduct(String category, ProductItem product) {
    if (categoryData1.containsKey(category)) {
      categoryData1[category]!.add(product);
    } else {
      categoryData1[category] = [product];
    }
    notify();
  }

  // Methode zum Entfernen eines Produkts
  void removeProduct(String category, ProductItem product) {
    if (categoryData1.containsKey(category)) {
      categoryData1[category]!.remove(product);
      if (categoryData1[category]!.isEmpty) {
        categoryData1.remove(category);
      }
      notify();
    }
  }
}
