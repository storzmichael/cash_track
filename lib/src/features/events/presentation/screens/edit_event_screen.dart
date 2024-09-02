import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/core/presentation/theme_container.dart';
import 'package:cash_track/src/features/events/domain/event_textfield_item.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:cash_track/src/features/general_widgets/presentation/custom_txt_field.dart';
import 'package:cash_track/src/features/general_widgets/presentation/outlined_big_button.dart';
import 'package:cash_track/src/features/order/data/category_data_map.dart';

import 'package:cash_track/src/features/order/data/products_list.dart';
import 'package:cash_track/src/features/order/domain/product_item.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class EditEventScreen extends StatefulWidget {
  const EditEventScreen({super.key});

  @override

  // ignore: library_private_types_in_public_api
  _EditEventScreenState createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //_loadProducts();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  addProductToGrid() {
    ProductItem product1 = ProductItem(
        productTitle: _nameController.text,
        productPrice: _priceController.text,
        productCategory: _categoryController.text);

    productsData.add(product1);

    if (_categoryController.text.isEmpty || _nameController.text.isEmpty || _priceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Eines der Felder ist leer, bitte alle Felder ausfüllen."),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    double? price;
    try {
      price = double.parse(_priceController.text.replaceAll(',', '.'));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Bitte geben Sie einen gültigen Preis ein."),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Ausgabe für Card
    final String product = '${_nameController.text} - ${price.toStringAsFixed(2)}';

    setState(() {
      if (categoryData.containsKey(_categoryController.text)) {
        categoryData[_categoryController.text]!.add(product);
      } else {
        categoryData[_categoryController.text] = [product];
      }

      clearAllController();

      //_saveProducts();
    });
  }

  void clearAllController() {
    _nameController.clear();
    _priceController.clear();
    _categoryController.clear();
  }
  //! nur zu Testzwecken
  // Future<void> _saveProducts() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final Map<String, List<String>> productsMap = _categorizedProducts;
  //   final Map<String, String> stringMap = {};

  //   productsMap.forEach((category, products) {
  //     stringMap[category] = products.join(';');
  //   });

  //   await prefs.setString('products', stringMap.entries.map((e) => '${e.key}:${e.value}').join('|'));
  // }

  // Future<void> _loadProducts() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? productsString = prefs.getString('products');
  //   if (productsString != null) {
  //     final Map<String, List<String>> loadedProducts = {};
  //     final Map<String, String> map = {};

  //     productsString.split('|').forEach((element) {
  //       final parts = element.split(':');
  //       if (parts.length == 2) {
  //         map[parts[0]] = parts[1];
  //       }
  //     });

  //     map.forEach((category, products) {
  //       loadedProducts[category] = products.split(';').toList();
  //     });

  //     setState(() {
  //       _categorizedProducts.addAll(loadedProducts);
  //     });
  //   }
  // }

  void _showProductOptionsDialog(String category, String product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Aktionen für Produkt'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Produkt: $product'),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _showEditProductDialog(category, product);
                      clearAllController();
                    },
                    child: const Text('Ändern'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _deleteProduct(category, product);
                      clearAllController();
                    },
                    child: const Text('Löschen'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEditProductDialog(String category, String product) {
    final parts = product.split(' - ');
    final String name = parts[0];
    final String price = parts[1];

    _nameController.text = name;
    _priceController.text = price;
    _categoryController.text = category;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Produkt bearbeiten'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                controller: _nameController,
                eventTextfieldItem: const EventTextfieldItem(
                  eventTextfieldHintText: 'Produktname',
                ),
                onChanged: (value) {},
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _priceController,
                // Add custom input validation here
                onChanged: (value) {
                  if (!RegExp(r'^[0-9]*[.,]?[0-9]*$').hasMatch(value)) {
                    // Show error or handle invalid input
                  }
                },
                eventTextfieldItem: const EventTextfieldItem(
                  eventTextfieldHintText: 'Produktpreis',
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _updateProduct(category, product);
              },
              child: const Text('Speichern'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Abbrechen'),
            ),
          ],
        );
      },
    );
  }

  void _updateProduct(String category, String oldProduct) {
    final String newName = _nameController.text.trim();
    final String newPriceText = _priceController.text.trim();

    double? newPrice;
    try {
      newPrice = double.parse(newPriceText.replaceAll(',', '.'));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Bitte geben Sie einen gültigen Preis ein."),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final String newProduct = '$newName - ${newPrice.toStringAsFixed(2)}';

    setState(() {
      final products = categoryData[category];
      if (products != null) {
        final index = products.indexOf(oldProduct);
        if (index != -1) {
          products[index] = newProduct;
        }
        //_saveProducts();
      }
    });

    _nameController.clear();
    _priceController.clear();
    _categoryController.clear();
  }

  void _deleteProduct(String category, String product) {
    setState(() {
      final products = categoryData[category];
      if (products != null) {
        products.remove(product);
        if (products.isEmpty) {
          categoryData.remove(category);
        }
        // _saveProducts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          ),
        ],
        title: const Text('Produkte erstellen'),
      ),
      body: Stack(
        children: [
          const ThemeContainer(),
          Padding(
            padding: const EdgeInsets.all(sitesPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: _nameController,
                  eventTextfieldItem: const EventTextfieldItem(
                    eventTextfieldHintText: 'Produktname',
                  ),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _priceController,
                  // Add custom input validation here
                  onChanged: (value) {
                    if (!RegExp(r'^[0-9]*[.,]?[0-9]*$').hasMatch(value)) {
                      // Show error or handle invalid input
                    }
                  },
                  eventTextfieldItem: const EventTextfieldItem(
                    eventTextfieldHintText: 'Produktpreis',
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _categoryController,
                  eventTextfieldItem: const EventTextfieldItem(
                    eventTextfieldHintText: 'Produktkategorie',
                  ),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 30),
                Center(
                  child: SizedBox(
                    width: 200,
                    height: bigBttnHeight,
                    child: OutlinedBigButton(
                      buttonName: 'Hinzufügen',
                      onPressed: addProductToGrid,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text('Produktliste nach Kategorien'),
                const SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: categoryData.entries.map((entry) {
                        final String category = entry.key;
                        final List<String> products = entry.value;

                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            width: 200,
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    category,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: products.length,
                                    itemBuilder: (context, index) {
                                      final product = products[index];
                                      final parts = product.split(' - ');
                                      final name = parts[0];
                                      final price = parts[1];

                                      return GestureDetector(
                                        onLongPress: () {
                                          _showProductOptionsDialog(category, product);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(name),
                                              ),
                                              Text('$price €'),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: bigBttnHeight),
                BigButton(
                  buttonName: 'Erstelle Event ',
                  onPressed: () {
                    Navigator.pushNamed(context, "/order");
                  },
                ),
                const SizedBox(
                  height: bottomPadding,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}