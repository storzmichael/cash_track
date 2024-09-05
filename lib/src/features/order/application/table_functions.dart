import 'package:flutter/material.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/order/data/table_list.dart';

class TableFunctions {
  // Funktion zum Hinzufügen eines neuen Buttons (Tisch)
  static void addNewButton(BuildContext context, String buttonName, String language, Function setStateCallback) {
    if (buttonName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(textFiles[language]![9]),
          backgroundColor: alertColor,
        ),
      );
      return;
    }

    if (tables.contains(buttonName)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${textFiles[language]![10]} "$buttonName" ${textFiles[language]![11]}'),
          backgroundColor: alertColor,
        ),
      );
      return;
    }

    setStateCallback(() {
      tables.add(buttonName);
      tables.sort(); // Sortiere die Liste alphabetisch
    });
  }

  // Funktion zum Anzeigen eines Bestätigungsdialogs zum Löschen eines Tisches
  static void showDeleteConfirmDialog(BuildContext context, int index, String language, Function setStateCallback) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(textFiles[language]![16]),
          content: Text(textFiles[language]![17]),
          actions: <Widget>[
            TextButton(
              child: Text(textFiles[language]![13]),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(textFiles[language]![18]),
              onPressed: () {
                setStateCallback(() {
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

  // Dialog zum Hinzufügen eines neuen Tisches
  static void showAddButtonDialog(BuildContext context, String language, Function setStateCallback) {
    final TextEditingController buttonTextController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(textFiles[language]![12]),
          content: TextField(
            controller: buttonTextController,
            decoration: InputDecoration(
              hintText: textFiles[language]![13],
              // Hier Farbe des Unterstrichs ändern
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: primeryColor), // Farbe des Unterstrichs im Standardzustand
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: primeryColor), // Farbe des Unterstrichs im Fokuszustand
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                textFiles[language]![14],
                style: const TextStyle(color: blackColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(textFiles[language]![15]),
              onPressed: () {
                String buttonName = buttonTextController.text.trim();
                addNewButton(context, buttonName, language, setStateCallback);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
