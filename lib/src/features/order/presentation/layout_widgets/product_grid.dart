import 'package:cash_track/src/features/order/domain/product_item.dart';
import 'package:cash_track/src/features/order/presentation/single_widgets/button_product_custom.dart';
import 'package:flutter/material.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductItem> productItemsList; // Liste der Produkte, die im Grid angezeigt werden
  final int crossAxisCount; // Anzahl der Spalten im Grid
  final double crossAxisSpacing; // Abstand zwischen den Spalten
  final double mainAxisSpacing; // Abstand zwischen den Reihen
  final void Function(ProductItem productItem) onPressed; // Variable onPressed Methode

  const ProductGrid({
    super.key,
    required this.productItemsList, // Erfordert eine Liste der Produkte
    required this.onPressed, // Erfordert die onPressed Methode
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

        // Direktzugriff auf das 'productTitle' Feld der ProductItem Klasse
        if (item.productTitle == 'default') {
          return const SizedBox.shrink(); // Rückgabe eines leeren Widgets
        }

        return ButtonProductCustom(
          productItem: item, // Übergabe des Produkts an das Button-Widget
          onPressed: () => onPressed(item), // Aktion bei Knopfdruck
        );
      },
    );
  }
}
