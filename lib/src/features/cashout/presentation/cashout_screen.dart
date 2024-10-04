import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/cashout/presentation/single_widgets/listview_unpaid.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:flutter/material.dart';

class CashoutScreen extends StatelessWidget {
  final int? selectedTable; // Ausgewählte Tischnummer, als Parameter übergeben
  final String orderSum; // Dynamische Bestellsumme
  final bool isContainerEmpty; // Dynamischer Containerstatus
  final bool isSelect = true;
  final double monitorHeight = 200;

  const CashoutScreen({
    super.key,
    this.selectedTable,
    this.orderSum = '0.00', // Standardwert
    this.isContainerEmpty = true, // Standardwert
  });

  Widget _title() {
    return Text('${textFiles[language]![3]}: $deskNumber'); // Dynamische Anzeige der ausgewählten Tischnummer
  }

  Widget _monitorScreen() {
    return Container(
      height: monitorHeight,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(monitorBorderRadius),
        ),
        color: textFieldColor,
      ),
    );
  }

  Widget _orderSummary() {
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
              Text(orderSum),
            ],
          ),
        ),
      ),
    );
  }

  Widget _payButton() {
    return SizedBox(
      height: bigBttnHeight,
      child: BigButton(
        buttonName: textFiles[language]![5], // Text aus der Sprachdatei
        backgroundColor: (isContainerEmpty) // Standardwert auf true, wenn null
            ? Colors.grey.shade300
            : primeryColor,
        textColor: (isContainerEmpty) ? Colors.grey.shade500 : Colors.black,
        onPressed: (isContainerEmpty) ? null : () {}, // Button deaktiviert, wenn der Container leer ist
      ),
    );
  }

  Widget _pending() {
    return Text(
      textFiles[language]![6], // Text aus der Sprachdatei
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(), // Anzeige des dynamischen Titels
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
                      const Expanded(
                        child: ListViewUnpaid(), // Anzeige der unbezahlten Positionen
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
  }
}
