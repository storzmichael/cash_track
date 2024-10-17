import 'package:cash_track/src/features/order/application/order_provider.dart';

import 'package:cash_track/src/features/order/presentation/single_widgets/button_product_custom.dart';
import 'package:flutter/material.dart';
import 'package:cash_track/src/features/order/domain/product_item.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  final List productItemsList; // Liste der Produkte, die im Grid angezeigt werden
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
    final orderProvider = Provider.of<OrderProvider>(context);

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
            orderProvider.addToSelect(item, context);
            // Aktion bei Knopfdruck: Produkt wird der Bestellung hinzugefügt

            // ignore: avoid_print
            print(item.productPrice); // Ausgabe des Produktpreises zur Überprüfung
            // ignore: avoid_print
            print(item.productTitle); // Ausgabe des Produktnamens zur Überprüfung
            // ignore: avoid_print
            print(orderProvider.orderDeskProducts); // Ausgabe der gesamten Bestellung zur Überprüfung
          },
        );
      },
    );
  }
}
