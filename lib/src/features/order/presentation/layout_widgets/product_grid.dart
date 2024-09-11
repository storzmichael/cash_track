import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/features/order/data/order_data_map.dart';
import 'package:cash_track/src/features/order/presentation/single_widgets/button_product_custom.dart';
import 'package:flutter/material.dart';
import 'package:cash_track/src/features/order/domain/product_item.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductItem> productItemsList; // Liste der Produkte, die im Grid angezeigt werden
  final int crossAxisCount; // Anzahl der Spalten im Grid
  final double crossAxisSpacing; // Abstand zwischen den Spalten
  final double mainAxisSpacing; // Abstand zwischen den Reihen

  const ProductGrid({
    super.key,
    required this.productItemsList, // Erfordert eine Liste der Produkte
    this.crossAxisCount = 4, // Standardmäßig 4 Spalten
    this.crossAxisSpacing = 10, // Standardabstand zwischen den Spalten
    this.mainAxisSpacing = 20, // Standardabstand zwischen den Reihen
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(), // Verhindert das Scrollen
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount, // Anzahl der Spalten
        crossAxisSpacing: crossAxisSpacing, // Abstand zwischen den Spalten
        mainAxisSpacing: mainAxisSpacing, // Abstand zwischen den Reihen
      ),
      itemCount: productItemsList.length, // Anzahl der Produkte im Grid
      itemBuilder: (context, index) {
        final item = productItemsList[index]; // Holen des Produkts aus der Liste
        return ButtonProductCustom(
          productItem: item, // Übergabe des Produkts an das Button-Widget
          onPressed: () {
            // Aktion bei Knopfdruck: Produkt wird der Bestellung hinzugefügt
            orderData[deskNumber] = ProductItem(
                productTitle: item.productTitle, // Titel des Produkts
                productPrice: item.productPrice, // Preis des Produkts
                productCategory: item.productCategory); // Kategorie des Produkts
            print('${item.productPrice}'); // Ausgabe des Produktpreises zur Überprüfung
            print('${item.productTitle}'); // Ausgabe des Produktnamens zur Überprüfung
            print(orderData); // Ausgabe der gesamten Bestellung zur Überprüfung
          },
        );
      },
    );
  }
}
