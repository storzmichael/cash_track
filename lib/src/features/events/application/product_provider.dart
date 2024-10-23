import 'package:cash_track/src/features/order/domain/product_item.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  // Die Map zur Speicherung der Produktkategorien und -artikel
  Map<String, List> categoryData = {
    'Getränke': [
      ProductItem(productTitle: 'Cola', productPrice: 3.00, productCategory: 'Getränke'),
      ProductItem(productTitle: 'Fanta', productPrice: 3.00, productCategory: 'Getränke'),
      ProductItem(productTitle: 'Wasser', productPrice: 2.50, productCategory: 'Getränke'),
      ProductItem(productTitle: 'Wein', productPrice: 3.50, productCategory: 'Getränke'),
      ProductItem(productTitle: 'Bier', productPrice: 4.00, productCategory: 'Getränke'),
    ],
    'Essen': [
      ProductItem(productTitle: 'Pommes', productPrice: 4.00, productCategory: 'Essen'),
      ProductItem(productTitle: 'Grillwurst', productPrice: 4.00, productCategory: 'Essen'),
      ProductItem(productTitle: 'Salat', productPrice: 4.00, productCategory: 'Essen'),
    ]
  };

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
    if (categoryData.containsKey(category)) {
      categoryData[category]!.add(product);
    } else {
      categoryData[category] = [product];
    }
    notify();
  }

  // Methode zum Entfernen eines Produkts
  void removeProduct(String category, ProductItem product) {
    if (categoryData.containsKey(category)) {
      categoryData[category]!.remove(product);
      if (categoryData[category]!.isEmpty) {
        categoryData.remove(category);
      }
      notify();
    }
  }
}
