import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/features/order/application/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListViewUnpaid extends StatelessWidget {
  const ListViewUnpaid({super.key});

  final double _containerHeight = 300;

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, orderProvider, child) {
      // Zugriff auf orderData Map
      final orderData = orderProvider.orderData;

      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(borderRadius),
            topRight: Radius.circular(borderRadius),
          ),
          color: textFieldColor,
        ),
        height: _containerHeight,
        child: Padding(
          padding: const EdgeInsets.all(allSitesPadding),
          child: ListView.builder(
            itemCount: orderData[orderProvider.deskNumber]?.length ?? 0, // Anzahl der Produkte für den Tisch
            itemBuilder: (context, index) {
              // Hole das Produkt für den aktuellen Index
              final product = orderData[orderProvider.deskNumber]?[index];

              // Überprüfen, ob product null ist
              if (product == null) {
                return const ListTile(
                  title: Text('Produkt nicht gefunden'),
                );
              }

              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                leading: Text('${product.quantity} x'), // Menge
                title: Text(product.productTitle), // Produktname
                trailing: Text('${product.productPrice.toStringAsFixed(2)} €'), // Kategorie oder Preis
              );
            },
          ),
        ),
      );
    });
  }
}
