import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/core/presentation/dialog_helper.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/order/data/table_list.dart';
import 'package:cash_track/src/features/order/domain/product_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderProvider with ChangeNotifier {
  bool _isTableSelect = false;

  bool get isTableSelect => _isTableSelect;

  // Neue Methode zur Aktualisierung des Tischstatus
  void setTableSelect(bool value) {
    _isTableSelect = value;
    notifyListeners(); // Benachrichtigt die Listener über die Änderung
  }

  String deskNumber = '';

  // Liste der ausgewählten Produkte
  List<ProductItem> _selectedProducts = [];

  // Getter für die ausgewählten Produkte
  List<ProductItem> get selectedProducts => _selectedProducts;

  // Funktion zum Hinzufügen eines neuen Buttons (Tisch)
  void addNewButton(
    BuildContext context,
    String buttonName,
    String language,
  ) {
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
    notifyListeners();
  }

  // Dialog zum Hinzufügen eines neuen Tisches
  void showAddButtonDialog(
    BuildContext context,
    String language,
  ) {
    DialogHelper.showTextInputDialog(
      context: context,
      title: textFiles[language]![12], // Dialogtitel
      placeholder: textFiles[language]![13], // Platzhaltertext
      cancelButtonText: textFiles[language]![14], // Text für Abbrechen-Button
      confirmButtonText: textFiles[language]![15], // Text für Bestätigen-Button
      onConfirm: (buttonName) {
        addNewButton(
          context,
          buttonName,
          language,
        ); // Bearbeiten der Aktion zum Hinzufügen des Buttons
      },
    );
    notifyListeners();
  }

  void showSettingButtonDialog(
    BuildContext context,
    String language,
  ) {
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
    notifyListeners();
  }

  void showDeleteConfirmDialog(
    BuildContext context,
    int index,
    String language,
  ) {
    DialogHelper.showConfirmationDialog(
      context: context,
      title: textFiles[language]![16], // Titel des Bestätigungsdialogs
      message: textFiles[language]![17], // Inhalt des Bestätigungsdialogs
      cancelButtonText: textFiles[language]![14], // Text für Abbrechen-Button
      confirmButtonText: textFiles[language]![18], // Text für Löschen-Button
      onConfirm: () {
        // Aktion zum Entfernen des Elements
        tables.removeAt(index); // Entfernt den Tisch mit dem angegebenen Index
        notifyListeners(); // Benachrichtige über die Änderung
      },
    );
  }

  // Funktion zum Hinzufügen eines Produkts zur Bestellung
  void addToSelect(ProductItem product, BuildContext context) {
    if (product.availability > 0) {
      // Überprüfen, ob das Produkt bereits ausgewählt wurde
      final existingProduct = _selectedProducts.firstWhere(
        (prod) => prod.productTitle == product.productTitle,
        orElse: () => ProductItem(
          productTitle: '',
          productPrice: 0,
          productCategory: '',
        ),
      );

      if (existingProduct.productTitle != '') {
        existingProduct.quantity++;
      } else {
        _selectedProducts.add(ProductItem(
          productTitle: product.productTitle,
          productPrice: product.productPrice,
          productCategory: product.productCategory,
          availability: product.availability,
          quantity: 1,
        ));
      }

      product.availability--; // Verfügbarkeit des Produkts reduzieren
      notifyListeners();
    } else {
      // Wenn das Produkt nicht verfügbar ist, zeige eine Nachricht
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Dieses Produkt ist nicht mehr verfügbar.'),
        ),
      );
    }
  }

  void clearMonitor() {
    _selectedProducts.clear();
    notifyListeners();
  }

  double get totalPrice {
    double total = 0.0;
    for (var product in _selectedProducts) {
      total += product.productPrice * product.quantity;
    }
    return total;
  }

  void removeProduct(ProductItem product, BuildContext context) {
    final existingProduct = _selectedProducts.firstWhere(
      (prod) => prod.productTitle == product.productTitle,
      orElse: () => ProductItem(productTitle: '', productPrice: 0, productCategory: ''), // Platzhalter
    );

    if (existingProduct.productTitle != '') {
      if (existingProduct.quantity > 1) {
        existingProduct.quantity--;
      } else {
        _selectedProducts.remove(existingProduct);
      }

      product.availability++;
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Dieses Produkt ist nicht im Warenkorb.'),
        ),
      );
    }
  }
}
