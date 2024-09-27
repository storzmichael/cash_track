import 'package:cash_track/src/core/presentation/dialog_helper.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/order/data/table_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TableFunctions {
  // Funktion zum Hinzufügen eines neuen Buttons (Tisch)
  static void addNewButton(BuildContext context, String buttonName, String language, Function setStateCallback) {
    // Überprüfung, ob der Button-Name leer ist
    if (buttonName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(textFiles[language]![9]),
          backgroundColor: alertColor,
        ),
      );
      return;
    }

    // Überprüfung, ob der Tischname bereits existiert
    if (tables.contains(buttonName)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${textFiles[language]![10]} "$buttonName" ${textFiles[language]![11]}'),
          backgroundColor: alertColor,
        ),
      );
      return;
    }

    // Hinzufügen des neuen Tisches und Sortieren der Liste
    setStateCallback(() {
      tables.add(buttonName);
      tables.sort((a, b) {
        // Vergleich von Strings numerisch, falls sie Zahlen enthalten, ansonsten alphabetisch
        final int? numA = int.tryParse(a);
        final int? numB = int.tryParse(b);
        if (numA != null && numB != null) {
          return numA.compareTo(numB);
        }
        return a.compareTo(b);
      });
    });
  }

  // Dialog zum Hinzufügen eines neuen Tisches
  static void showAddButtonDialog(BuildContext context, String language, Function setStateCallback) {
    DialogHelper.showTextInputDialog(
      context: context,
      title: textFiles[language]![12], // Dialogtitel
      placeholder: textFiles[language]![13], // Platzhaltertext
      cancelButtonText: textFiles[language]![14], // Text für Abbrechen-Button
      confirmButtonText: textFiles[language]![15], // Text für Bestätigen-Button
      onConfirm: (buttonName) {
        addNewButton(
            context, buttonName, language, setStateCallback); // Bearbeiten der Aktion zum Hinzufügen des Buttons
      },
    );
  }

  static void showSettingButtonDialog(BuildContext context, String language, Function setStateCallback) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Settings'), // Dialogtitel
          content: const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text('Was wollen Sie tun?'), // Frage
          ),
          actions: [
            // Erster Textbutton
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pushNamed(context, "/createProducts");
              },
              child: const Text('zum Produkt'), // Text für den ersten Button
            ),
            // Zweiter Textbutton
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pushNamed(context, "/appHome");
              },
              isDestructiveAction: true, // Roter Text für eine wichtige Option (z. B. löschen oder verlassen)
              child: const Text('Event verlassen'), // Text für den zweiten Button
            ),
            // Abbrechen Button (optional)
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context); // Schließt den Dialog
              },
              child: const Text('Abbrechen'), // Text für Abbrechen-Button
            ),
          ],
        );
      },
    );
  }

  // Funktion zum Anzeigen eines Bestätigungsdialogs zum Löschen eines Tisches
  static void showDeleteConfirmDialog(BuildContext context, int index, String language, Function setStateCallback) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(textFiles[language]![16]), // Titel des Bestätigungsdialogs
          content: Text(textFiles[language]![17]), // Inhalt des Bestätigungsdialogs
          actions: <Widget>[
            TextButton(
              child: Text(textFiles[language]![13]), // Text für Abbrechen-Button
              onPressed: () {
                Navigator.of(context).pop(); // Schließt den Dialog, ohne zu löschen
              },
            ),
            TextButton(
              child: Text(textFiles[language]![18]), // Text für Bestätigen-Button
              onPressed: () {
                setStateCallback(() {
                  tables.removeAt(index); // Entfernt den Tisch mit dem angegebenen Index aus der Liste
                });
                Navigator.of(context).pop(); // Schließt den Dialog nach dem Löschen
              },
            ),
          ],
        );
      },
    );
  }
}
