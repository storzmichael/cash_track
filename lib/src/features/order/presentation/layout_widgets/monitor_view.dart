import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/order/application/order_provider.dart';
import 'package:cash_track/src/features/order/data/order_data_map.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonitorView extends StatelessWidget {
  const MonitorView({super.key});

  // Höhe des Monitors (Bildschirms) für die Anzeige
  final double _monitorHeight = 160;

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    return Column(
      children: [
        // Erste Zeile: Enthält Bestellungsdetails und den Tischmonitor
        Consumer<OrderProvider>(
          builder: (context, orderProvider, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Verteilung der Elemente in der Zeile
              children: [
                // Anzeige der Bestellsumme (links)
                Flexible(
                  flex: 2, // Nimmt zwei Drittel der Breite ein
                  child: SizedBox(
                    height: _monitorHeight, // Höhe des Containers
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(monitorBorderRadius), // Abgerundete Ecken links
                        ),
                        color: monitorColor, // Hintergrundfarbe
                      ),
                      child: Scrollbar(
                        child: ListView.builder(
                          itemCount: orderProvider.selectedProducts.length, //, // Anzahl der bestellten Produkte
                          itemBuilder: (context, index) {
                            final product = orderProvider.selectedProducts[index];
                            return SizedBox(
                              height: 28,
                              child: ListTile(
                                leading: Text('${product.quantity.toString()} x'),
                                title: Text(product.productTitle),
                                trailing: Text('${(product.productPrice * product.quantity).toStringAsFixed(2)}€'),
                                onTap: () {
                                  orderProvider.removeProduct(product, context);
                                  print('löschen eines des Produkts');
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 2), // Abstand zwischen den beiden Teilen
                // Anzeige des Tischmonitors (rechts)
                Flexible(
                  flex: 1, // Nimmt ein Drittel der Breite ein
                  child: SizedBox(
                    height: _monitorHeight, // Höhe des Containers
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(monitorBorderRadius), // Abgerundete Ecken rechts
                        ),
                        color: monitorColor, // Hintergrundfarbe
                      ),
                      child: ListView.builder(
                        itemCount: orderData.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Text('Tisch:'),
                            title: Text('1'),
                            onTap: () {
                              Navigator.pushNamed(context, "/cashout");
                              print('Gehe zum Bezahlen-Screen für Tisch 1');
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(
          height: 8, // Abstand zwischen den Elementen
        ),
        // Zweite Zeile: Anzeige der Gesamtsumme
        SizedBox(
          height: 40, // Höhe des Summenfelds
          width: double.infinity, // Nimmt die gesamte Breite ein
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(8), // Abgerundete Ecken des Containers
              ),
              color: textFieldColor, // Hintergrundfarbe
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 8.0), // Innenabstand links und rechts
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Verteilung von Texten am Rand
                children: [
                  Text(textFiles[language]![4]), // Text für "Gesamtsumme" oder ähnliches
                  Text('${orderProvider.totalPrice.toStringAsFixed(2)}€'), // Anzeige der Gesamtsumme
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
