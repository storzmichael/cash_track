import 'dart:developer';

import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/core/presentation/dialog_helper.dart';
import 'package:cash_track/src/data/lang/app_text.dart';

import 'package:cash_track/src/features/order/domain/product_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderProvider with ChangeNotifier {
  bool _isTableSelect = false;
  bool get isTableSelect => _isTableSelect;

  bool _isCategorySelect = false;
  bool get isCategorySelect => _isCategorySelect;

  // Neue Methode zur Aktualisierung des Tischstatus
  void setTableSelect(bool value) {
    _isTableSelect = value;
    notifyListeners(); // Benachrichtigt die Listener über die Änderung
  }

  void setCategorySelect(bool value) {
    _isCategorySelect = value;
    notifyListeners(); // Benachrichtigt die Listener über die Änderung
  }

  String _deskNumber = '';

  String get deskNumber => _deskNumber;

  // Setter für deskNumber
  void setDeskNumber(String deskNumber) {
    _isTableSelect = true;
    _deskNumber = deskNumber;
    // Optional: Initialisiere die orderData für diesen Tisch, falls nicht bereits vorhanden
    if (!orderDeskProducts.containsKey(deskNumber)) {
      _orderDeskProducts[deskNumber] = [];
    }
    notifyListeners(); // Notify listeners about the change
  }

  final List<String> _orderDeskNumbers = [];
  List<String> get orderDeskNumbers => _orderDeskNumbers;

  void addDeskNumber(String deskNumber) {
    if (!_orderDeskNumbers.contains(deskNumber)) {
      _orderDeskNumbers.add(deskNumber);
      _isTableSelect = true;
      notifyListeners(); // Benachrichtigt die Listener über die Änderung
    }
  }

  // Liste der ausgewählten Produkte
  final List<ProductItem> _selectedProducts = [];
  List<ProductItem> get selectedProducts => _selectedProducts;

  final Map<String, List<ProductItem>> _orderDeskProducts = {};
  Map<String, List<ProductItem>> get orderDeskProducts => _orderDeskProducts;

  final List<String> _tables = ['1', '2', '3', '4', '5', '6', '7', 'Theke'];
  List<String> get tables => _tables;

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

//  Funktion zum Hinzufügen eines Produkts zur Bestellung (orderDeskProducts)
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
        SnackBar(
          content: Text(textFiles[language]![77]),
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

  void removeProductfromSelect(ProductItem product, BuildContext context) {
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
        SnackBar(
          content: Text(textFiles[language]![78]),
        ),
      );
    }
  }

  // fügt die Produkt von der Liste selectedProducts der Map orderDeskProducts hinzu
  void transferProductsToOrder() {
    while (selectedProducts.isNotEmpty) {
      ProductItem product = selectedProducts.removeAt(0); // Entferne das Produkt von der Liste

      // Überprüfen, ob die Tischnummer bereits in der Map vorhanden ist
      if (!orderDeskProducts.containsKey(_deskNumber)) {
        orderDeskProducts[_deskNumber] = []; // Initialisiere die Liste, falls sie nicht existiert
      }

      // Zugriff auf die Produktliste am aktuellen Tisch
      List<ProductItem> productsAtDesk = orderDeskProducts[_deskNumber]!;

      // Überprüfe, ob ein Produkt mit dem gleichen Titel bereits vorhanden ist
      final existingProductIndex = productsAtDesk.indexWhere(
        (p) => p.productTitle == product.productTitle,
      );

      if (existingProductIndex != -1) {
        // Wenn das Produkt bereits vorhanden ist, erhöhe die Menge um die Menge des neuen Produkts
        productsAtDesk[existingProductIndex].quantity += product.quantity;
      } else {
        // Andernfalls füge das Produkt zur Liste in der Map hinzu
        productsAtDesk.add(ProductItem(
          productTitle: product.productTitle,
          productPrice: product.productPrice,
          productCategory: product.productCategory,
          quantity: product.quantity, // Setze die Menge des neuen Produkts
        ));
      }
    }

    // Benachrichtige die Listener über die Änderungen
    notifyListeners();
  }

  String? selectedCategoryKey;
  void setCategory(String categoryKey) {
    selectedCategoryKey = categoryKey;
    notifyListeners();
  }

  //----------------------------------------------------------------

  final List<ProductItem> _cashoutProducts = []; // Zwischenspeichern der zu bezahlenden Produkte

  List<ProductItem> get cashoutProducts => _cashoutProducts; // Getter für entfernte Produkte

  // Funktion zum Entfernen eines Produkts von einem Tisch und Speichern in einer neuen Liste
  void addProductToCashout(String deskNumber, ProductItem product) {
    if (_orderDeskProducts.containsKey(deskNumber)) {
      // Finde die Produktliste für den Tisch
      List<ProductItem> products = _orderDeskProducts[deskNumber] ?? [];

      // Überprüfen, ob das Produkt vorhanden ist
      final existingProduct = products.firstWhere(
        (p) => p.productTitle == product.productTitle,
        orElse: () => ProductItem(productTitle: '', productPrice: 0, productCategory: ''),
      );

      // Wenn das Produkt gefunden wurde und seine Verfügbarkeit > 0 ist
      if (existingProduct.productTitle.isNotEmpty && existingProduct.quantity > 0) {
        // Füge das Produkt zur Liste der Cashout-Produkte hinzu, aber mit Menge 1
        _cashoutProducts.add(ProductItem(
          productTitle: existingProduct.productTitle,
          productPrice: existingProduct.productPrice,
          productCategory: existingProduct.productCategory,
          quantity: 1, // Füge nur 1 Stück hinzu
        ));

        // Reduziere die Menge des vorhandenen Produkts in der Tischliste
        existingProduct.quantity--;

        // Wenn die Menge auf 0 fällt, entferne das Produkt aus der Liste für den Tisch
        if (existingProduct.quantity == 0) {
          products.removeWhere((p) => p.productTitle == product.productTitle);
        }

        // Aktualisiere die Liste für den Tisch
        _orderDeskProducts[deskNumber] = products;

        // Benachrichtige alle Listener über die Änderung
        notifyListeners();
      }
    }
  }

  //----------------------------------------------------------------

  final List<ProductItem> _paidProducts = []; // Alle bezahlten Produkte speichern
  List<ProductItem> get paidProducts => _paidProducts;

  void addToPaidProducts() {
    // Übertrage Produkte von cashoutProducts nach paidProducts
    paidProducts.addAll(cashoutProducts);

    // Leere die cashoutProducts Liste
    cashoutProducts.clear();

    // Protokolliere die Produkte in der Konsole (optional)
    log(paidProducts.toString());

    // Benachrichtige die Listener über die Änderungen
    notifyListeners();
  }

  void returnProductToOrder(ProductItem product, BuildContext context) {
    final existingProduct = cashoutProducts.firstWhere(
      (prod) => prod.productTitle == product.productTitle,
      orElse: () => ProductItem(productTitle: '', productPrice: 0, productCategory: ''), // Platzhalter
    );

    if (existingProduct.productTitle != '') {
      // Entferne das Produkt aus cashoutProducts
      if (existingProduct.quantity > 1) {
        existingProduct.quantity--;
      } else {
        cashoutProducts.remove(existingProduct);
      }

      // Füge das Produkt zurück in die Map orderDeskProducts
      if (orderDeskProducts.containsKey(_deskNumber)) {
        final orderProducts = orderDeskProducts[_deskNumber]!;
        final orderProduct = orderProducts.firstWhere(
          (prod) => prod.productTitle == product.productTitle,
          orElse: () => ProductItem(productTitle: '', productPrice: 0, productCategory: ''), // Platzhalter
        );

        if (orderProduct.productTitle != '') {
          orderProduct.quantity++; // Erhöhe die Menge im order
        } else {
          // Wenn das Produkt nicht gefunden wurde, füge es als neues Produkt hinzu
          product.quantity = 1; // Setze die Menge auf 1
          orderProducts.add(product); // Füge das Produkt zur Bestellliste hinzu
        }
      }

      // Benachrichtige die Listener über die Änderungen
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(textFiles[language]![78]), // Nachricht für nicht vorhandenes Produkt
        ),
      );
    }
  }

  double get totalPriceToPay {
    double total = 0.0;
    for (var product in cashoutProducts) {
      total += product.productPrice * product.quantity;
    }
    return total;
  }
}
