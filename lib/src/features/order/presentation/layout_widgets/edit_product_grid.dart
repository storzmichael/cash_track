import 'dart:developer';
import 'package:cash_track/src/features/events/presentation/screens/create_product_screen.dart.dart';
import 'package:cash_track/src/features/order/presentation/single_widgets/button_product_custom.dart';
import 'package:flutter/material.dart';
import 'package:cash_track/src/features/order/domain/product_item.dart';
import 'package:provider/provider.dart'; // Provider importieren
import 'package:cash_track/src/features/events/application/product_provider.dart'; // Importiere deinen ProductProvider

class EditProductGrid extends StatelessWidget {
  final List<ProductItem> productItemsList;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final void Function(ProductItem productItem) onPressed;

  const EditProductGrid({
    super.key,
    required this.productItemsList,
    required this.onPressed,
    this.crossAxisCount = 4,
    this.crossAxisSpacing = 10,
    this.mainAxisSpacing = 20,
  });

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context); // Holen des ProductProviders

    // Falls die Liste weniger als 12 Einträge hat, fülle sie mit leeren `ProductItem`
    final List<ProductItem> filledProductItems = List<ProductItem>.from(productItemsList);
    while (filledProductItems.length < 12) {
      filledProductItems.add(ProductItem(
        productTitle: '',
        productPrice: 0,
      ));
    }

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
      ),
      itemCount: filledProductItems.length,
      itemBuilder: (context, index) {
        final item = filledProductItems[index];
        return ButtonProductCustom(
          productItem: item,
          onPressed: () {
            // Nutze WidgetsBinding, um den Navigator-Aufruf nach dem Build-Vorgang zu planen
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (item.productTitle.isEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateProductScreen(
                      index: index,
                      product: item,
                    ),
                  ),
                );
              } else {
                onPressed(item); // Hier die Logik für das Bearbeiten des Produkts
              }
            });

            // Loggen der Kategorie-Produkt-Map
            log(productProvider.categoryProductMap.toString());
          },
        );
      },
    );
  }
}
