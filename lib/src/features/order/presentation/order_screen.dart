import 'package:cash_track/src/config/config.dart';
import 'package:flutter/material.dart';
import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/core/presentation/theme_container.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:cash_track/src/features/order/data/category_data_map.dart';
import 'package:cash_track/src/features/order/data/table_list.dart';
import 'package:cash_track/src/features/order/presentation/layout_widgets/category_row.dart';
import 'package:cash_track/src/features/order/presentation/layout_widgets/monitor_view.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool isTableSelect = false; // Status der Auswahl, initial auf false gesetzt
  String deskNumber = ''; // Aktuelle Tischnummer
  final bool _isContainerEmpty = false;

  void _addNewButton(String buttonName) {
    if (buttonName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Bitte geben Sie etwas ein'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (tables.contains(buttonName)) {
      // Zeige Fehlermeldung an, wenn der Name bereits existiert
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tisch mit dem Namen "$buttonName" existiert bereits!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      tables.add(buttonName);
      tables.sort(); // Sortiere die Liste alphabetisch
    });
  }

  void showAddButtonDialog() {
    final TextEditingController buttonTextController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Neuen Button hinzufügen'),
          content: TextField(
            controller: buttonTextController,
            decoration: const InputDecoration(
              hintText: 'Button Name eingeben',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Abbrechen'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Hinzufügen'),
              onPressed: () {
                String buttonName = buttonTextController.text.trim();
                _addNewButton(buttonName);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Button löschen'),
          content: const Text('Möchten Sie diesen Button wirklich löschen?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Abbrechen'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Löschen'),
              onPressed: () {
                setState(() {
                  tables.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isTableSelect ? Text('Tischnummer: $deskNumber') : const Text('Tischnummer wählen'),
        actions: [
          IconButton(
            onPressed: showAddButtonDialog,
            icon: const Icon(Icons.add),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Stack(
        children: [
          const ThemeContainer(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const MonitorView(),
                  const SizedBox(height: 24),
                  isTableSelect
                      ? Expanded(
                          child: CategoryRow(
                            category: categoryData,
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: tables.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: GestureDetector(
                                  onLongPress: () => _showDeleteConfirmDialog(index),
                                  child: SizedBox(
                                    height: 40,
                                    child: BigButton(
                                      backgroundColor: Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          deskNumber = tables[index];
                                          isTableSelect = true;
                                        });
                                      },
                                      buttonName: tables[index],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                  SizedBox(
                    height: bigBttnHeight,
                    child: BigButton(
                        buttonName: 'Bestellen',
                        backgroundColor: isTableSelect ? orangeColor : Colors.grey.shade300,
                        textColor: isTableSelect ? Colors.black : Colors.grey.shade500,
                        onPressed: isTableSelect
                            ? () {
                                setState(() {
                                  isTableSelect = false; // Setze isTableSelect zurück
                                });
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
