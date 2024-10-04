import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  void notify() {
    notifyListeners();
  }

  void disposeControllers() {
    nameController.dispose();
    priceController.dispose();
    categoryController.dispose();
  }
}
