import 'package:flutter/cupertino.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:flutter/material.dart';

class DialogHelper {
  // Wiederverwendbarer Cupertino-Dialog für die Texteingabe
  static void showTextInputDialog({
    required BuildContext context, // Der BuildContext des aktuellen Widgets
    required String title, // Titel des Dialogs
    required String placeholder, // Platzhaltertext für das Eingabefeld
    required String cancelButtonText, // Text für die Abbrechen-Schaltfläche
    required String confirmButtonText, // Text für die Bestätigen-Schaltfläche
    required Function(String) onConfirm, // Callback-Funktion, die den eingegebenen Text verarbeitet
    String? initialValue = '', // Optionaler Anfangswert für das Textfeld
    TextEditingController? controller, // Optionaler Controller für das Textfeld
  }) {
    final TextEditingController textController = TextEditingController(text: initialValue);

    // Zeigt einen Cupertino-Dialog mit Texteingabe an
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title), // Titel des Dialogs
          content: Column(
            children: [
              const SizedBox(height: 16), // Abstand zwischen Titel und Inhalt
              CupertinoTextField(
                autofocus: true, // Aktiviert das Textfeld beim Öffnen
                controller: textController, // TextController zur Verwaltung des Eingabewerts
                placeholder: placeholder, // Platzhaltertext
              ),
            ],
          ),
          actions: <Widget>[
            // Abbrechen-Schaltfläche
            CupertinoDialogAction(
              isDefaultAction: true,
              child:
                  Text(cancelButtonText, style: const TextStyle(color: blackColor)), // Stil der Abbrechen-Schaltfläche
              onPressed: () {
                Navigator.of(context).pop(); // Schließt den Dialog
              },
            ),
            // Bestätigen-Schaltfläche
            CupertinoDialogAction(
              child: Text(confirmButtonText,
                  style: const TextStyle(color: primeryColor)), // Stil der Bestätigen-Schaltfläche
              onPressed: () {
                String inputText = textController.text.trim(); // Entfernt führende/trailende Leerzeichen
                onConfirm(inputText); // Ruft die Callback-Funktion mit dem eingegebenen Text auf
                Navigator.of(context).pop(); // Schließt den Dialog
              },
            ),
          ],
        );
      },
    );
  }

  // Wiederverwendbarer Cupertino-Dialog ohne Texteingabe
  static void showConfirmationDialog({
    required BuildContext context, // Der BuildContext des aktuellen Widgets
    required String title, // Titel des Dialogs
    required String message, // Nachricht im Dialog
    required String cancelButtonText, // Text für die Abbrechen-Schaltfläche
    required String confirmButtonText, // Text für die Bestätigen-Schaltfläche
    Color textColor = primeryColor, // Farbe des Bestätigungsbuttons (Standard: primeryColor)
    required Function() onConfirm, // Callback-Funktion für die Bestätigungsaktion
  }) {
    // Zeigt einen Cupertino-Dialog zur Bestätigung an
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title), // Titel des Dialogs
          content: Column(
            mainAxisSize: MainAxisSize.min, // Stellt sicher, dass der Dialog nicht zu groß ist
            children: [
              const SizedBox(height: 16), // Abstand zwischen Titel und Nachricht
              Text(
                message, // Nachrichtentext
                style: const TextStyle(color: Colors.black), // Stil der Nachricht
              ),
              const SizedBox(height: 16), // Abstand unterhalb der Nachricht
            ],
          ),
          actions: <Widget>[
            // Abbrechen-Schaltfläche
            CupertinoDialogAction(
              isDefaultAction: true,
              child:
                  Text(cancelButtonText, style: const TextStyle(color: blackColor)), // Stil der Abbrechen-Schaltfläche
              onPressed: () {
                Navigator.of(context).pop(); // Schließt den Dialog
              },
            ),
            // Bestätigen-Schaltfläche
            CupertinoDialogAction(
              child: Text(confirmButtonText, style: TextStyle(color: textColor)), // Stil der Bestätigen-Schaltfläche
              onPressed: () {
                onConfirm(); // Ruft die Callback-Funktion für die Bestätigungsaktion auf
                Navigator.of(context).pop(); // Schließt den Dialog
              },
            ),
          ],
        );
      },
    );
  }
}
