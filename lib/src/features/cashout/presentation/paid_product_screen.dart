import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/order/application/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaidProductsScreen extends StatelessWidget {
  const PaidProductsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, child) {
        // Berechnung des Gesamtpreises für alle bezahlten Produkte
        final totalPrice = orderProvider.paidProducts.fold(0.0, (sum, product) {
          return sum + (product.productPrice * product.quantity);
        });

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                // Navigation zurück zur Bestellübersicht
                Navigator.pushNamed(context, "/order");
              },
              icon: Icon(
                Icons.chevron_left,
                size: 30, // Hier kannst du die gewünschte Größe angeben
              ),
            ),
            title: Text(textFiles[language]![88]), // Titel aus der Sprachdatei
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        lightThemeList[0],
                        lightThemeList[1],
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      bottomPadding,
                      sitesPadding,
                      bottomPadding,
                      sitesPadding,
                    ),
                    child: ListView.builder(
                      // Listet alle bezahlten Produkte auf
                      itemCount: orderProvider.paidProducts.length,
                      itemBuilder: (context, index) {
                        final product = orderProvider.paidProducts[index];
                        return ListTile(
                          title: Text(product.productTitle),
                          subtitle: Text('${product.quantity} x ${product.productPrice.toStringAsFixed(2)} €'),
                          trailing: Text('${(product.productPrice * product.quantity).toStringAsFixed(2)} €'),
                        );
                      },
                    ),
                  ),
                ),
              ),
              // Bereich für die Anzeige des Gesamtpreises
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      textFiles[language]![4], // Gesamtpreistext aus der Sprachdatei
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${totalPrice.toStringAsFixed(2)} €', // Gesamtpreis für die bezahlten Produkte
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SafeArea(child: SizedBox()) // SafeArea stellt sicher, dass nichts unter der Statusleiste verdeckt wird
            ],
          ),
        );
      },
    );
  }
}
