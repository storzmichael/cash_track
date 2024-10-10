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
                          return ListView.builder(
                            itemCount: orderProvider.orderDeskNumbers.length,
                            itemBuilder: (context, index) {
                              final deskNumber = orderProvider.orderDeskNumbers[index];

                              // Überprüfen, ob es für den Tisch Produkte gibt
                              if (orderProvider.orderDeskProducts.containsKey(deskNumber) &&
                                  orderProvider.orderDeskProducts[deskNumber]!.isNotEmpty) {
                                return ListTile(
                                  leading: Text('Tisch:'),
                                  title: Text(deskNumber),
                                  onTap: () {
                                    // Setze die aktuelle Tisch-Nummer auf den ausgewählten Tisch
                                    orderProvider.setDeskNumber(deskNumber);

                                    // Logs zum Überprüfen der Produkte in der orderData
                                    log('Produkte in orderData: ${orderProvider.orderDeskProducts.map((key, value) => MapEntry(key, value.toString()))}');
                                    log('Aktuelle Auswahl $deskNumber: ${orderProvider.orderDeskProducts[deskNumber]}');
                                    log('zustand des tisch: ${orderProvider.isTableSelect}');
                                    log('Verfügbare tische: ${orderProvider.tables}');

                                    // Navigiere zum Cashout-Screen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CashoutScreen(selectedTable: deskNumber),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                // Falls der Tisch keine Produkte enthält, wird kein ListTile angezeigt
                                return const SizedBox.shrink(); // Rückgabe eines leeren Containers
                              }
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
