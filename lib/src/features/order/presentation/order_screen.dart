import 'dart:developer';
import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/events/application/product_provider.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:cash_track/src/features/order/application/order_provider.dart';
import 'package:cash_track/src/features/order/presentation/layout_widgets/category_row.dart';
import 'package:cash_track/src/features/order/presentation/layout_widgets/monitor_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cash_track/src/features/settings/application/language_provider.dart';

// Diese Klasse stellt den OrderScreen dar, auf dem der Benutzer Bestellungen verwalten kann.
class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Zugriff auf verschiedene Provider für den Zugriff auf den Bestell- und Sprachstatus sowie Produktdaten.
    final orderProvider = Provider.of<OrderProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context); // Zugriff auf den ProductProvider

    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Stellt sicher, dass der Inhalt bei der Anzeige der Tastatur nicht abgeschnitten wird.
      appBar: AppBar(
        automaticallyImplyLeading: false, // Verhindert das automatische Hinzufügen einer Zurück-Schaltfläche
        title: Consumer<OrderProvider>(
          builder: (context, orderProvider, child) {
            return orderProvider.isTableSelect
                ? GestureDetector(
                    onTap: () {
                      // Wenn ein Tisch ausgewählt wurde, kann der Benutzer darauf tippen, um den Tisch auszuwählen.
                      orderProvider.setTableSelect(false);
                    },
                    child: Text(
                      '${textFiles[languageProvider.language]![3]}: ${orderProvider.deskNumber}',
                    ),
                  )
                : Text(
                    textFiles[languageProvider.language]![46], // Titel, wenn kein Tisch ausgewählt ist
                  );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Zeigt den Einstellungsdialog an, wenn der Benutzer auf das Zahnrad-Icon klickt
              orderProvider.showSettingButtonDialog(context, languageProvider.language);
            },
            icon: const Icon(Icons.settings),
          ),
          !orderProvider.isTableSelect
              ? IconButton(
                  onPressed: () => orderProvider.showAddButtonDialog(context, languageProvider.language),
                  icon: const Icon(Icons.add), // Zeigt das Plus-Symbol an, wenn kein Tisch ausgewählt wurde
                )
              : const SizedBox.shrink(),
          const SizedBox(width: 16),
        ],
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
                padding: const EdgeInsets.all(sitesPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MonitorView(), // Anzeige des Monitors für Bestellungen
                    const Expanded(child: SizedBox()),
                    Consumer<OrderProvider>(
                      builder: (context, orderProvider, child) {
                        return orderProvider.isTableSelect
                            ? SizedBox(
                                height: gridheight,
                                child: CategoryRow(
                                  categories:
                                      productProvider.categories, // Anzeige der Kategorien aus dem ProductProvider
                                ),
                              )
                            : SizedBox(
                                height: gridheight,
                                child: GridView.builder(
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount, // Anzahl der Spalten in der GridView
                                    crossAxisSpacing: crossAxisSpacing, // Abstand zwischen den Spalten
                                    mainAxisSpacing: mainAxisSpacing, // Abstand zwischen den Zeilen
                                    mainAxisExtent: bigBttnHeight, // Höhe der einzelnen GridItems
                                  ),
                                  itemCount: orderProvider.tables.length, // Anzahl der Tische
                                  itemBuilder: (context, index) {
                                    return AspectRatio(
                                      aspectRatio: aspectRatio, // Verhältnis für die Ansicht der GridItems
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                                        child: GestureDetector(
                                          onLongPress: () => orderProvider.showDeleteConfirmDialog(
                                            context,
                                            index,
                                            languageProvider.language,
                                          ), // Zeigt einen Dialog, um den Tisch zu löschen
                                          child: SizedBox(
                                            height: bigBttnHeight,
                                            child: BigButton(
                                              backgroundColor: primeryColorLow, // Button-Hintergrundfarbe
                                              onPressed: () {
                                                // Tischnummer setzen und Tischnummer zur Liste hinzufügen
                                                orderProvider.setDeskNumber(orderProvider.tables[index]);
                                                orderProvider.addDeskNumber(orderProvider.deskNumber);

                                                print(orderProvider.deskNumber);
                                                log('Zustand Tisch: ${orderProvider.isTableSelect}');
                                                log('Verfügbare Tische: ${orderProvider.tables}');
                                              },
                                              buttonName: orderProvider.tables[index], // Tischname anzeigen
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                      },
                    ),
                    const SizedBox(height: 24),
                    Consumer<OrderProvider>(
                      builder: (context, orderProvider, child) {
                        return SizedBox(
                          height: bigBttnHeight,
                          child: BigButton(
                            buttonName: textFiles[languageProvider.language]![45], // "Bestellen"-Button
                            backgroundColor: orderProvider.selectedProducts.isNotEmpty
                                ? primeryColor
                                : disabledBttnColor, // Button-Farbe abhängig vom Status
                            textColor: orderProvider.selectedProducts.isNotEmpty
                                ? blackColor
                                : disabledTextColor, // Textfarbe abhängig vom Status
                            onPressed: orderProvider.selectedProducts.isNotEmpty
                                ? () {
                                    // Bestellprozess starten, wenn Produkte ausgewählt wurden
                                    orderProvider.setTableSelect(false);
                                    orderProvider.setCategorySelect(false);
                                    orderProvider.transferProductsToOrder();
                                    orderProvider.clearMonitor();
                                    log('Zustand Tisch: ${orderProvider.isTableSelect}');
                                    log('Produkte in selectedProducts: ${orderProvider.selectedProducts}');
                                  }
                                : null, // Der Button ist deaktiviert, wenn keine Produkte ausgewählt sind
                          ),
                        );
                      },
                    ),
                    SizedBox(
                        height:
                            bottomSafeArea), // Sichert, dass der Button bei Bedarf nicht durch die Tastatur verdeckt wird
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
