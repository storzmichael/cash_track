import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/cashout/presentation/single_widgets/listview_unpaid.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:cash_track/src/features/order/application/order_provider.dart';
import 'package:cash_track/src/features/order/presentation/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cash_track/src/features/settings/application/language_provider.dart'; // Importiere den LanguageProvider

class CashoutScreen extends StatelessWidget {
  final String? selectedTable; // Ausgewählte Tischnummer, als Parameter übergeben
  final String orderSum; // Dynamische Bestellsumme
  final bool isContainerEmpty; // Dynamischer Containerstatus
  final double monitorHeight = 200;

  // Konstruktor der CashoutScreen-Klasse
  CashoutScreen({
    super.key,
    this.selectedTable,
    this.orderSum = '0.00', // Standardwert für die Bestellsumme
    this.isContainerEmpty = true, // Standardwert für den Containerstatus
  });

  // Widget für den Monitor-Bereich, der die Bestellungen anzeigt
  Widget _monitorScreen(BuildContext context) {
    return Container(
      height: monitorHeight,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(monitorBorderRadius),
        ),
        color: textFieldColor,
      ),
      child: Consumer<OrderProvider>(
        builder: (context, orderProvider, child) {
          return ListView.builder(
            itemCount: orderProvider.cashoutProducts.length,
            itemBuilder: (context, index) {
              final product = orderProvider.cashoutProducts[index];

              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                leading: Text('${product.quantity} x'), // Zeigt die Menge des Produkts an
                title: Text(product.productTitle), // Zeigt den Produkttitel an
                trailing: Text(
                    '${(product.productPrice * product.quantity).toStringAsFixed(2)} €'), // Zeigt den Gesamtpreis des Produkts an
                onTap: () {
                  // Entfernt das Produkt aus der Bestellung, wenn darauf geklickt wird
                  orderProvider.returnProductToOrder(product, context);
                },
              );
            },
          );
        },
      ),
    );
  }

  // Widget für die Anzeige der Bestellzusammenfassung
  Widget _orderSummary(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    final String language = languageProvider.language;

    return Consumer<OrderProvider>(builder: (context, orderProvider, child) {
      return SizedBox(
        height: bigBttnHeight,
        width: double.infinity,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(monitorBorderRadius),
            ),
            color: textFieldColor,
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: textPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(textFiles[language]![4]), // Text aus der Sprachdatei
                Text('${orderProvider.totalPriceToPay.toStringAsFixed(2)}€'), // Zeigt die zu zahlende Gesamtsumme an
              ],
            ),
          ),
        ),
      );
    });
  }

  // Widget für den "Bezahlen"-Button
  Widget _payButton(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    final String language = languageProvider.language;

    return Consumer<OrderProvider>(builder: (context, orderProvider, child) {
      return SizedBox(
        height: bigBttnHeight,
        child: BigButton(
          buttonName: textFiles[language]![5], // Text aus der Sprachdatei
          backgroundColor: (orderProvider.cashoutProducts.isEmpty)
              ? Colors.grey.shade300
              : primeryColor, // Hintergrundfarbe basierend auf dem Status der Bestellung
          textColor: (orderProvider.cashoutProducts.isEmpty)
              ? Colors.grey.shade500
              : Colors.black, // Textfarbe basierend auf dem Status der Bestellung
          onPressed: (orderProvider.cashoutProducts.isEmpty)
              ? null
              : () =>
                  orderProvider.addToPaidProducts(), // Wenn keine Produkte vorhanden sind, ist der Button deaktiviert
        ),
      );
    });
  }

  // Widget für die Anzeige von "Pending" (noch zu bezahlende Produkte)
  Widget _pending(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    final String language = languageProvider.language;

    return Text(
      textFiles[language]![6], // Text aus der Sprachdatei
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('${textFiles[language]![3]}: $selectedTable'), // Zeigt den Titel mit der Tischnummer an
            automaticallyImplyLeading: false,
            leading: orderProvider.cashoutProducts.isEmpty
                ? IconButton(
                    onPressed: () {
                      // Navigiert zurück zur Bestellansicht, wenn der Warenkorb leer ist
                      Provider.of<OrderProvider>(context, listen: false).setTableSelect(false);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => OrderScreen()),
                      );
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  )
                : null, // Führt keine Aktion aus, wenn der Warenkorb nicht leer ist
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
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
                    padding: const EdgeInsets.fromLTRB(bottomPadding, sitesPadding, bottomPadding, sitesPadding),
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom, // Berücksichtigt die Höhe der Tastatur
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _monitorScreen(context), // Zeigt den Monitor-Bereich an
                          const SizedBox(height: 8),
                          _orderSummary(context), // Zeigt die Bestellzusammenfassung an
                          const SizedBox(height: 24),
                          _payButton(context), // Zeigt den Bezahlen-Button an
                          const SizedBox(height: 24),
                          _pending(context), // Zeigt den "Pending"-Text an
                          const SizedBox(height: 8),
                          Expanded(
                            child: ListViewUnpaid(
                              selectedTable: selectedTable, // Zeigt die unbezahlten Artikel an
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
