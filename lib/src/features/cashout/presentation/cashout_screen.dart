import 'dart:developer';

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

class CashoutScreen extends StatelessWidget {
  final String? selectedTable; // Ausgewählte Tischnummer, als Parameter übergeben
  final String orderSum; // Dynamische Bestellsumme
  final bool isContainerEmpty; // Dynamischer Containerstatus
  final bool isSelect = true;
  final double monitorHeight = 200;

  CashoutScreen({
    super.key,
    this.selectedTable,
    this.orderSum = '0.00', // Standardwert
    this.isContainerEmpty = true, // Standardwert
  });

  Widget _monitorScreen() {
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
            itemCount: orderProvider.cashoutProducts.length, // Anzahl der Produkte für den Cashout
            itemBuilder: (context, index) {
              final product = orderProvider.cashoutProducts[index]; // Hole das Produkt für den aktuellen Index

              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                leading: Text('${product.quantity} x'), // Menge des Produkts
                title: Text(product.productTitle), // Produktname
                trailing:
                    Text('${(product.productPrice * product.quantity).toStringAsFixed(2)} €'), // Preis für die Menge
                onTap: () {
                  orderProvider.returnProductToOrder(product, context);
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _orderSummary() {
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
                Text('${orderProvider.totalPriceToPay.toStringAsFixed(2)}€'),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _payButton() {
    return Consumer<OrderProvider>(builder: (context, orderProvider, child) {
      return SizedBox(
        height: bigBttnHeight,
        child: BigButton(
            buttonName: textFiles[language]![5], // Text aus der Sprachdatei
            backgroundColor: (orderProvider.cashoutProducts.isEmpty) // Standardwert auf true, wenn null
                ? Colors.grey.shade300
                : primeryColor,
            textColor: (orderProvider.cashoutProducts.isEmpty) ? Colors.grey.shade500 : Colors.black,
            onPressed: (orderProvider.cashoutProducts.isEmpty)
                ? null
                : () => orderProvider.addToPaidProducts() // Button deaktiviert, wenn der Container leer ist

            ),
      );
    });
  }

  Widget _pending() {
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
            title: Text('${textFiles[language]![3]}: $selectedTable'), // Anzeige des dynamischen Titels
            automaticallyImplyLeading: false,
            leading: orderProvider.cashoutProducts.isEmpty
                ? IconButton(
                    onPressed: () {
                      Provider.of<OrderProvider>(context, listen: false)
                          .setTableSelect(false); // Setze isTableSelect auf false
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => OrderScreen()),
                      );
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  )
                : null, // Kein Chevron anzeigen, wenn cashoutProducts nicht leer ist
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
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _monitorScreen(),
                          const SizedBox(height: 8),
                          _orderSummary(),
                          const SizedBox(height: 24),
                          _payButton(),
                          const SizedBox(height: 24),
                          _pending(),
                          const SizedBox(height: 8),
                          Expanded(
                            child: ListViewUnpaid(
                              selectedTable: selectedTable,
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
