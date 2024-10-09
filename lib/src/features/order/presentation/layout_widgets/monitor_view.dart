import 'dart:developer';

import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/cashout/presentation/cashout_screen.dart';
import 'package:cash_track/src/features/order/application/order_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonitorView extends StatelessWidget {
  const MonitorView({super.key});

  final double _monitorHeight = 160;
  // Höhe des Monitors (Bildschirms) für die Anzeige

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
                              },
                            ),
                          );

                          /*Row(
                          children: [
                            const Text('1x'), // Beispiel für die Anzahl eines Produkts
                            const SizedBox(
                              width: 8, // Abstand zwischen Anzahl und Produktnamen
                            ),
                            Text(_orderItems[index].productTitle), // Anzeige des Produktnamens
                            const Expanded(child: SizedBox()), // Füllt den verfügbaren Platz
                            Text('${_orderItems[index].productPrice} €'), // Anzeige des Produktpreises
                          ],
                        );*/
                        },
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
                      child: Consumer<OrderProvider>(
                        builder: (context, orderProvider, child) {
                          final orderData = orderProvider.orderData;
                          return ListView.builder(
                              itemCount: orderData.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: Text('Tisch:'),
                                  title: Text(orderProvider.deskNumbers[index]),
                                  onTap: () {
                                    orderProvider.setDeskNumber(orderProvider.deskNumbers[index]);
                                    log('Produkte in orderData: ${orderProvider.orderData.map((key, value) => MapEntry(key, value.toString()))}');
                                    log('Aktuelle Auswahl ${orderProvider.deskNumber}: ${orderProvider.orderData[orderProvider.deskNumber]}');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CashoutScreen(selectedTable: orderProvider.deskNumbers[index])));
                                  },
                                );
                              });
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
