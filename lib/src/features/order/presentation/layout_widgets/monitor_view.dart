import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/order/data/products_list.dart';
import 'package:cash_track/src/features/order/domain/product_item.dart';
import 'package:flutter/material.dart';

class MonitorView extends StatefulWidget {
  const MonitorView({super.key});

  @override
  State<MonitorView> createState() => _MonitorViewState();
}

class _MonitorViewState extends State<MonitorView> {
  final double valueList = 2.50; // Beispielwert für eine Produktliste
  final String orderSum = '2,50 €'; // Beispiel für die Summe der Bestellung
  final List<ProductItem> _orderItems = productsData; // Liste der bestellten Produkte
  final double _monitorHeight = 160; // Höhe des Monitors (Bildschirms) für die Anzeige

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      children: [
        // Erste Zeile: Enthält Bestellungsdetails und den Tischmonitor
        Row(
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
                    itemCount: _orderItems.length, // Anzahl der bestellten Produkte
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          const Text('1x'), // Beispiel für die Anzahl eines Produkts
                          const SizedBox(
                            width: 8, // Abstand zwischen Anzahl und Produktnamen
                          ),
                          Text(_orderItems[index].productTitle), // Anzeige des Produktnamens
                          const Expanded(child: SizedBox()), // Füllt den verfügbaren Platz
                          Text('${_orderItems[index].productPrice} €'), // Anzeige des Produktpreises
                        ],
                      );
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
                ),
              ),
            ),
          ],
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
                  Text(orderSum), // Anzeige der Gesamtsumme
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
