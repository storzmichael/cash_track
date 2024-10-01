import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';

import 'package:cash_track/src/core/presentation/theme_container.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:cash_track/src/features/order/application/order_provider.dart';

import 'package:cash_track/src/features/order/data/category_data_map.dart';

import 'package:cash_track/src/features/order/data/table_list.dart';
import 'package:cash_track/src/features/order/presentation/layout_widgets/category_row.dart';
import 'package:cash_track/src/features/order/presentation/layout_widgets/monitor_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//TODO: umbau zum provider
class OrderScreen extends StatelessWidget {
  OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const int crossAxisCount = 2; // Anzahl der Spalten im GridView
    const double crossAxisSpacing = 24; // Abstand zwischen den Spalten
    const double mainAxisSpacing = 16; // Abstand zwischen den Zeilen
    const double aspectRatio = 2; // Verhältnis von Breite zu Höhe der Tische
    const double gridheight = 379; // Höhe des Grids min. 379

    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Entfernt das Chevron-Symbol
        title: Consumer<OrderProvider>(builder: (context, orderProvider, child) {
          return orderProvider.isTableSelect
              ? GestureDetector(
                  onTap: () {
                    orderProvider.setTableSelect(true); // Setzt den Tischstatus zurück
                  },
                  child: Text('${textFiles[language]![3]}: $deskNumber')) // Zeigt den ausgewählten Tisch an
              : Text(
                  textFiles[language]![46], // Zeigt den Standardtitel an, wenn kein Tisch ausgewählt wurde
                );
        }),
        actions: [
          IconButton(
            onPressed: () {
              orderProvider.showSettingButtonDialog(context, language);
            }, // Öffnet den Dialog zum Auswählen eines Tisches
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () => orderProvider.showAddButtonDialog(context, language), // Fügt einen neuen Tisch hinzu
            icon: const Icon(Icons.add),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Stack(
        children: [
          const ThemeContainer(), // Hintergrundthema für den Bildschirm
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(sitesPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MonitorView(), // Zeigt den Bestellmonitor an
                  const Expanded(child: SizedBox()),

                  Consumer<OrderProvider>(
                    builder: (context, orderProvider, child) {
                      return orderProvider.isTableSelect
                          ? SizedBox(
                              height: gridheight,
                              child: CategoryRow(
                                  category:
                                      categoryData // Zeigt die Produktkategorien an, wenn ein Tisch ausgewählt ist
                                  ))
                          // Gridview für Tische
                          : SizedBox(
                              height: gridheight,
                              child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount, // Anzahl der Spalten
                                  crossAxisSpacing: crossAxisSpacing, // Abstand zwischen den Spalten
                                  mainAxisSpacing: mainAxisSpacing, // Abstand zwischen den Zeilen
                                  mainAxisExtent: bigBttnHeight, // Höhe der Buttons
                                ),
                                itemCount: tables.length, // Anzahl der verfügbaren Tische
                                itemBuilder: (context, index) {
                                  return AspectRatio(
                                    aspectRatio: aspectRatio, // Verhältnis von Breite zu Höhe des Tisches
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                                      child: GestureDetector(
                                        onLongPress: () => orderProvider.showDeleteConfirmDialog(
                                          context,
                                          index,
                                          language,
                                        ), // Öffnet Dialog zum Löschen des Tisches
                                        child: SizedBox(
                                          height: bigBttnHeight, // Höhe des Containers für den Button
                                          child: BigButton(
                                            backgroundColor: primeryColorLow, // Hintergrundfarbe des Tisch-Buttons
                                            onPressed: () {
                                              deskNumber = tables[index]; // Setzt den ausgewählten Tisch
                                              orderProvider.setTableSelect(true); // Aktiviert den Tisch
                                            },
                                            buttonName: tables[index], // Zeigt den Tischnamen an
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
                  const SizedBox(
                    height: 24,
                  ),
                  Consumer<OrderProvider>(
                    builder: (context, orderProvider, child) {
                      return SizedBox(
                        height: bigBttnHeight, // Höhe des unteren Buttons
                        child: BigButton(
                            buttonName: textFiles[language]![45], // "Bestellen"-Button
                            backgroundColor: orderProvider.isTableSelect
                                ? primeryColor
                                : disabledBttnColor, // Farbe des Buttons abhängig von der Tischauswahl
                            textColor: orderProvider.isTableSelect
                                ? blackColor
                                : disabledTextColor, // Textfarbe abhängig von der Tischauswahl
                            onPressed: orderProvider.isTableSelect
                                ? () {
                                    orderProvider.setTableSelect(false); // Setzt den Tischstatus zurück

                                    orderProvider.clearMonitor();
                                  }
                                : null),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
