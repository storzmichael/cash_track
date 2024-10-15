import 'dart:developer';

import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/core/presentation/dialog_helper.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/order/domain/product_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cash_track/src/features/settings/application/language_provider.dart'; // Importiere den LanguageProvider

class OrderProvider with ChangeNotifier {
  bool _isTableSelect = false;
  bool get isTableSelect => _isTableSelect;

  bool _isCategorySelect = false;
  bool get isCategorySelect => _isCategorySelect;

  void setTableSelect(bool value) {
    _isTableSelect = value;
    notifyListeners();
  }

  void setCategorySelect(bool value) {
    _isCategorySelect = value;
    notifyListeners();
  }

  String _deskNumber = '';
  String get deskNumber => _deskNumber;

  void setDeskNumber(String deskNumber) {
    _isTableSelect = true;
    _deskNumber = deskNumber;
    if (!_orderDeskProducts.containsKey(deskNumber)) {
      _orderDeskProducts[deskNumber] = [];
    }
    notifyListeners();
  }

  final List<String> _orderDeskNumbers = [];
  List<String> get orderDeskNumbers => _orderDeskNumbers;

  void addDeskNumber(String deskNumber) {
    if (!_orderDeskNumbers.contains(deskNumber)) {
      _orderDeskNumbers.add(deskNumber);
      _isTableSelect = true;
      notifyListeners();
    }
  }

  final List<ProductItem> _selectedProducts = [];
  List<ProductItem> get selectedProducts => _selectedProducts;

  final Map<String, List<ProductItem>> _orderDeskProducts = {};
  Map<String, List<ProductItem>> get orderDeskProducts => _orderDeskProducts;

  final List<String> _tables = ['1', '2', '3', '4', '5', '6', '7', 'Theke'];
  List<String> get tables => _tables;

  void addNewButton(BuildContext context, String buttonName, String language) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false); // Zugriff auf den LanguageProvider
    if (buttonName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(textFiles[languageProvider.language]![9]),
          backgroundColor: alertColor,
        ),
      );
      return;
    }

    if (tables.contains(buttonName)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '${textFiles[languageProvider.language]![10]} "$buttonName" ${textFiles[languageProvider.language]![11]}'),
          backgroundColor: alertColor,
        ),
      );
      return;
    }

    tables.add(buttonName);
    tables.sort((a, b) {
      final int? numA = int.tryParse(a);
      final int? numB = int.tryParse(b);
      if (numA != null && numB != null) {
        return numA.compareTo(numB);
      }
      return a.compareTo(b);
    });
    notifyListeners();
  }

  void showAddButtonDialog(BuildContext context, String language) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    DialogHelper.showTextInputDialog(
      context: context,
      title: textFiles[languageProvider.language]![12],
      placeholder: textFiles[languageProvider.language]![13],
      cancelButtonText: textFiles[languageProvider.language]![14],
      confirmButtonText: textFiles[languageProvider.language]![15],
      onConfirm: (buttonName) {
        addNewButton(context, buttonName, languageProvider.language);
      },
    );
  }

  void showSettingButtonDialog(BuildContext context, String language) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(textFiles[languageProvider.language]![49]),
          content: Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(textFiles[languageProvider.language]![80]),
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pushNamed(context, "/createProducts");
              },
              child: Text(textFiles[languageProvider.language]![81]),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pushNamed(context, "/appHome");
              },
              isDestructiveAction: true,
              child: Text(textFiles[languageProvider.language]![82]),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(textFiles[languageProvider.language]![14]),
            ),
          ],
        );
      },
    );
  }

  void showDeleteConfirmDialog(BuildContext context, int index, String language) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    DialogHelper.showConfirmationDialog(
      context: context,
      title: textFiles[languageProvider.language]![16],
      message: textFiles[languageProvider.language]![17],
      cancelButtonText: textFiles[languageProvider.language]![14],
      confirmButtonText: textFiles[languageProvider.language]![18],
      onConfirm: () {
        tables.removeAt(index);
        notifyListeners();
      },
    );
  }

  void addToSelect(ProductItem product, BuildContext context) {
    if (product.availability > 0) {
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

      product.availability--;
      notifyListeners();
    } else {
      final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(textFiles[languageProvider.language]![77]),
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
      orElse: () => ProductItem(productTitle: '', productPrice: 0, productCategory: ''),
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
      final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(textFiles[languageProvider.language]![78]),
        ),
      );
    }
  }

  void transferProductsToOrder() {
    while (selectedProducts.isNotEmpty) {
      ProductItem product = selectedProducts.removeAt(0);

      if (!orderDeskProducts.containsKey(_deskNumber)) {
        orderDeskProducts[_deskNumber] = [];
      }

      List<ProductItem> productsAtDesk = orderDeskProducts[_deskNumber]!;

      final existingProductIndex = productsAtDesk.indexWhere(
        (p) => p.productTitle == product.productTitle,
      );

      if (existingProductIndex != -1) {
        productsAtDesk[existingProductIndex].quantity += product.quantity;
      } else {
        productsAtDesk.add(ProductItem(
          productTitle: product.productTitle,
          productPrice: product.productPrice,
          productCategory: product.productCategory,
          quantity: product.quantity,
        ));
      }
    }

    notifyListeners();
  }

  String? selectedCategoryKey;
  void setCategory(String categoryKey) {
    selectedCategoryKey = categoryKey;
    notifyListeners();
  }

  final List<ProductItem> _cashoutProducts = [];
  List<ProductItem> get cashoutProducts => _cashoutProducts;

  void addProductToCashout(String deskNumber, ProductItem product) {
    if (_orderDeskProducts.containsKey(deskNumber)) {
      List<ProductItem> products = _orderDeskProducts[deskNumber] ?? [];

      final existingProduct = products.firstWhere(
        (p) => p.productTitle == product.productTitle,
        orElse: () => ProductItem(productTitle: '', productPrice: 0, productCategory: ''),
      );

      if (existingProduct.productTitle.isNotEmpty && existingProduct.quantity > 0) {
        _cashoutProducts.add(ProductItem(
          productTitle: existingProduct.productTitle,
          productPrice: existingProduct.productPrice,
          productCategory: existingProduct.productCategory,
          quantity: 1,
        ));

        existingProduct.quantity--;

        if (existingProduct.quantity == 0) {
          products.removeWhere((p) => p.productTitle == product.productTitle);
        }

        _orderDeskProducts[deskNumber] = products;
        notifyListeners();
      }
    }
  }

  final List<ProductItem> _paidProducts = [];
  List<ProductItem> get paidProducts => _paidProducts;

  void addToPaidProducts() {
    paidProducts.addAll(cashoutProducts);
    cashoutProducts.clear();
    log(paidProducts.toString());
    notifyListeners();
  }

  void returnProductToOrder(ProductItem product, BuildContext context) {
    final existingProduct = cashoutProducts.firstWhere(
      (prod) => prod.productTitle == product.productTitle,
      orElse: () => ProductItem(productTitle: '', productPrice: 0, productCategory: ''),
    );

    if (existingProduct.productTitle != '') {
      if (existingProduct.quantity > 1) {
        existingProduct.quantity--;
      } else {
        cashoutProducts.remove(existingProduct);
      }

      if (orderDeskProducts.containsKey(_deskNumber)) {
        final orderProducts = orderDeskProducts[_deskNumber]!;
        final orderProduct = orderProducts.firstWhere(
          (prod) => prod.productTitle == product.productTitle,
          orElse: () => ProductItem(productTitle: '', productPrice: 0, productCategory: ''),
        );

        if (orderProduct.productTitle != '') {
          orderProduct.quantity++;
        } else {
          product.quantity = 1;
          orderProducts.add(product);
        }
      }

      notifyListeners();
    } else {
      final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(textFiles[languageProvider.language]![78]),
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
