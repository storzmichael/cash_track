import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/core/application/navigation_functions.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/order/application/table_functions.dart';
import 'package:cash_track/src/features/order/data/table_list.dart';
import 'package:flutter/material.dart';
import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:cash_track/src/features/order/data/category_data_map.dart';
import 'package:cash_track/src/features/order/presentation/layout_widgets/category_row.dart';
import 'package:cash_track/src/features/order/presentation/layout_widgets/monitor_view.dart';
import 'package:cash_track/src/core/presentation/theme_container.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool isTableSelect = false; // Bestimmt, ob ein Tisch ausgewählt wurde
  final int _crossAxisCount = 2; // Anzahl der Spalten im GridView
  final double _crossAxisSpacing = 24; // Abstand zwischen den Spalten
  final double _mainAxisSpacing = 16; // Abstand zwischen den Zeilen
  final double _aspectRatio = 2; // Verhältnis von Breite zu Höhe der Tische
  final double _gridheight = 379; // Höhe des Grids min. 379
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Entfernt das Chevron-Symbol
        title: isTableSelect
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    isTableSelect = false; // Setzt den Tischstatus zurück
                  });
                },
                child: Text('${textFiles[language]![3]}: $deskNumber')) // Zeigt den ausgewählten Tisch an
            : Text(
                textFiles[language]![46], // Zeigt den Standardtitel an, wenn kein Tisch ausgewählt wurde
              ),
        actions: [
          IconButton(
            onPressed: () {
              TableFunctions.showSettingButtonDialog(context, language, setState);
            }, // Öffnet den Dialog zum Auswählen eines Tisches
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () =>
                TableFunctions.showAddButtonDialog(context, language, setState), // Fügt einen neuen Tisch hinzu
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
                  const MonitorView(), // Zeigt den Bestellmonitor an
                  const Expanded(child: SizedBox()),

                  isTableSelect
                      ? SizedBox(
                          height: _gridheight,
                          child: CategoryRow(
                              category: categoryData // Zeigt die Produktkategorien an, wenn ein Tisch ausgewählt ist
                              ))
                      // Gridview für Tische
                      : SizedBox(
                          height: _gridheight,
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: _crossAxisCount, // Anzahl der Spalten
                              crossAxisSpacing: _crossAxisSpacing, // Abstand zwischen den Spalten
                              mainAxisSpacing: _mainAxisSpacing, // Abstand zwischen den Zeilen
                              mainAxisExtent: bigBttnHeight, // Höhe der Buttons
                            ),
                            itemCount: tables.length, // Anzahl der verfügbaren Tische
                            itemBuilder: (context, index) {
                              return AspectRatio(
                                aspectRatio: _aspectRatio, // Verhältnis von Breite zu Höhe des Tisches
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: GestureDetector(
                                    onLongPress: () => TableFunctions.showDeleteConfirmDialog(
                                        context, index, language, setState), // Öffnet Dialog zum Löschen des Tisches
                                    child: SizedBox(
                                      height: bigBttnHeight, // Höhe des Containers für den Button
                                      child: BigButton(
                                        backgroundColor: primeryColorLow, // Hintergrundfarbe des Tisch-Buttons
                                        onPressed: () {
                                          setState(() {
                                            deskNumber = tables[index]; // Setzt den ausgewählten Tisch
                                            isTableSelect = true; // Aktiviert den Tisch
                                          });
                                        },
                                        buttonName: tables[index], // Zeigt den Tischnamen an
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: bigBttnHeight, // Höhe des unteren Buttons
                    child: BigButton(
                        buttonName: textFiles[language]![45], // "Bestellen"-Button
                        backgroundColor: isTableSelect
                            ? primeryColor
                            : disabledBttnColor, // Farbe des Buttons abhängig von der Tischauswahl
                        textColor:
                            isTableSelect ? blackColor : disabledTextColor, // Textfarbe abhängig von der Tischauswahl
                        onPressed: isTableSelect
                            ? () {
                                setState(() {
                                  isTableSelect = false; // Setzt den Tischstatus zurück
                                });
                                navigateToCashoutScreen(context); // Navigiert zum Bezahlbildschirm
                              }
                            : null),
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
