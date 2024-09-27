import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/core/application/navigation_functions.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/events/application/event_functions.dart';
import 'package:flutter/material.dart';
import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/core/presentation/theme_container.dart';
import 'package:cash_track/src/features/events/domain/event_textfield_item.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:cash_track/src/features/general_widgets/presentation/custom_txt_field.dart';
import 'package:cash_track/src/features/general_widgets/presentation/outlined_big_button.dart';
import 'package:cash_track/src/features/order/presentation/layout_widgets/category_row.dart';
import 'package:cash_track/src/features/order/domain/product_item.dart';
import 'package:cash_track/src/features/order/data/category_data_map.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateProductScreenState createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  final double cardHeight = 200;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _showEditProductDialog(String category, ProductItem product) {
    _nameController.text = product.productTitle;
    _priceController.text = product.productPrice;
    _categoryController.text = category;

    EventFunctions.showProductOptionsDialog(
      context,
      category,
      product,
      () => EventFunctions.deleteProduct(
        category: category,
        product: product,
        setStateCallback: setState,
      ),
      () => EventFunctions.updateProduct(
        context: context,
        category: category,
        oldProduct: product,
        newName: _nameController.text,
        newPriceText: _priceController.text,
        nameController: _nameController,
        priceController: _priceController,
        categoryController: _categoryController,
        setStateCallback: setState,
      ),
    );
  }

  Widget _addButton() {
    return Center(
      child: SizedBox(
        width: 200,
        height: bigBttnHeight,
        child: OutlinedBigButton(
          buttonName: textFiles[language]![15],
          onPressed: () {
            EventFunctions.addProductToGrid(
              context: context,
              category: _categoryController.text,
              productName: _nameController.text,
              productPrice: _priceController.text,
              nameController: _nameController,
              priceController: _priceController,
              categoryController: _categoryController,
              setStateCallback: setState,
            );
          },
        ),
      ),
    );
  }

  Widget _cardCategory() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categoryData.entries.map(
            (entry) {
              final String category = entry.key;
              final List<ProductItem> products = entry.value;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  width: cardHeight,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(category),
                      Expanded(
                        child: ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: GestureDetector(
                                onLongPress: () {
                                  EventFunctions.showProductOptionsDialog(
                                    context,
                                    category,
                                    product,
                                    () => EventFunctions.deleteProduct(
                                      category: category,
                                      product: product,
                                      setStateCallback: setState,
                                    ),
                                    () => _showEditProductDialog(category, product),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(product.productTitle),
                                    Text('${double.parse(product.productPrice).toStringAsFixed(2)} €'),
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
            },
          ).toList(),
        ),
      ),
    );
  }

  Widget _createEventButton() {
    return BigButton(
      buttonName: textFiles[language]![41],
      onPressed: () {
        CategoryRow.setCategory;
        Navigator.pushReplacementNamed(context, "/order");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Entfernt das Chevron-Symbol
        title: Text(textFiles[language]![36]),
      ),
      body: Stack(
        children: [
          const ThemeContainer(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(sitesPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Produktname
                  CustomTextField(
                    controller: _nameController,
                    eventTextfieldItem: EventTextfieldItem(
                      eventTextfieldHintText: textFiles[language]![37],
                    ),
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 10),
                  // Produktpreis
                  CustomTextField(
                    controller: _priceController,
                    onChanged: (value) {},
                    eventTextfieldItem: EventTextfieldItem(
                      eventTextfieldHintText: textFiles[language]![38],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Produktkategorie
                  CustomTextField(
                    controller: _categoryController,
                    eventTextfieldItem: EventTextfieldItem(
                      eventTextfieldHintText: textFiles[language]![39],
                    ),
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 30),
                  _addButton(),
                  const SizedBox(height: 30),
                  Text(textFiles[language]![40]),
                  const SizedBox(height: 10),
                  _cardCategory(),
                  const SizedBox(height: bigBttnHeight),
                  _createEventButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
