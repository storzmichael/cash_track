import 'package:cash_track/src/core/presentation/dialog_helper.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:flutter/material.dart';
import 'package:cash_track/src/features/order/data/category_data_map.dart';
import 'package:cash_track/src/features/order/domain/product_item.dart';

class EventFunctions {
  static void addProductToGrid({
    required BuildContext context,
    required String category,
    required String productName,
    required double productPrice,
    required TextEditingController nameController,
    required TextEditingController priceController,
    required TextEditingController categoryController,
    required Function setStateCallback,
  }) {
    if (category.isEmpty || productName.isEmpty || productPrice == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Eines der Felder ist leer, bitte alle Felder ausfüllen."),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final List<ProductItem>? products = categoryData[category];
    if (products != null && products.length >= 12) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text("Es sind bereits 12 Produkte in dieser Kategorie. Kein weiteres Produkt kann hinzugefügt werden."),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    ProductItem product = ProductItem(
      productTitle: productName,
      productPrice: productPrice,
      productCategory: category,
    );

    setStateCallback(() {
      if (categoryData.containsKey(category)) {
        categoryData[category]!.add(product);
      } else {
        categoryData[category] = [product];
      }

      clearAllControllers(nameController, priceController, categoryController);
    });
  }

  static void clearAllControllers(
    TextEditingController nameController,
    TextEditingController priceController,
    TextEditingController categoryController,
  ) {
    nameController.clear();
    priceController.clear();
    categoryController.clear();
  }

  static void showProductOptionsDialog(
    BuildContext context,
    String category,
    ProductItem product,
    Function deleteCallback,
    Function editCallback,
    String language,
  ) {
    // Nachricht für die Auswahl des Produkts
    String message = 'Produkt: ${product.productTitle}';

    DialogHelper.showConfirmationDialog(
      context: context,
      title: 'Aktionen für Produkt',
      message: message, // Inhalt des Dialogs
      cancelButtonText: textFiles[language]![13], // Text für Abbrechen-Button
      confirmButtonText: textFiles[language]![18], // Text für Löschen-Button
      onConfirm: () {
        // Aufruf der Lösch-Funktion
        deleteCallback();
      },
    );
  }

  static void updateProduct({
    required BuildContext context,
    required String category,
    required ProductItem oldProduct,
    required String newName,
    required String newPriceText,
    required TextEditingController nameController,
    required TextEditingController priceController,
    required TextEditingController categoryController,
    required Function setStateCallback,
  }) {
    double? newPrice;
    try {
      newPrice = double.parse(newPriceText.replaceAll(',', '.'));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Bitte geben Sie einen gültigen Preis ein."),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setStateCallback(() {
      final products = categoryData[category];
      if (products != null) {
        final index = products.indexOf(oldProduct);
        if (index != -1) {
          products[index] = ProductItem(
            productTitle: newName,
            productPrice: newPrice!,
            productCategory: category,
          );
        }
      }
    });

    clearAllControllers(nameController, priceController, categoryController);
  }

  static void deleteProduct({
    required String category,
    required ProductItem product,
    required Function setStateCallback,
  }) {
    setStateCallback(() {
      final products = categoryData[category];
      if (products != null) {
        products.remove(product);
        if (products.isEmpty) {
          categoryData.remove(category);
        }
      }
    });
  }
}
