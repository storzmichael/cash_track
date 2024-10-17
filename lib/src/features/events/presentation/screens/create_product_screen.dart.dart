import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/features/events/application/product_provider.dart';
import 'package:cash_track/src/features/events/domain/event_textfield_item.dart';
import 'package:cash_track/src/features/general_widgets/presentation/outlined_big_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cash_track/src/features/general_widgets/presentation/custom_txt_field.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/events/application/event_functions.dart';
import 'package:cash_track/src/features/settings/application/language_provider.dart'; // Importiere den LanguageProvider

class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({super.key});

  Widget _addButton(BuildContext context, ProductProvider productProvider, String language) {
    return Center(
      child: SizedBox(
        width: 200,
        height: bigBttnHeight,
        child: OutlinedBigButton(
          buttonName: textFiles[language]![15],
          onPressed: () {
            double? price = double.tryParse(productProvider.priceController.text.replaceAll(',', '.'));
            if (price == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(textFiles[language]![71]),
                  duration: const Duration(seconds: 2),
                ),
              );
              return;
            }
            EventFunctions.addProductToGrid(
              context: context,
              category: productProvider.categoryController.text,
              productName: productProvider.nameController.text,
              productPrice: price,
              nameController: productProvider.nameController,
              priceController: productProvider.priceController,
              categoryController: productProvider.categoryController,
            );
          },
        ),
      ),
    );
  }

  Widget _cardCategory(ProductProvider productProvider, String language) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: productProvider.categoryData.entries.map(
            (entry) {
              final String category = entry.key;
              final List products = entry.value;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  width: 200,
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
                                      context: context,
                                      category: category,
                                      product: product,
                                    ),
                                    () {
                                      productProvider.nameController.text = product.productTitle;
                                      productProvider.priceController.text = product.productPrice.toString();
                                      productProvider.categoryController.text = category;
                                      EventFunctions.updateProduct(
                                        context: context,
                                        category: category,
                                        oldProduct: product,
                                        newName: productProvider.nameController.text,
                                        newPriceText: productProvider.priceController.text,
                                        nameController: productProvider.nameController,
                                        priceController: productProvider.priceController,
                                        categoryController: productProvider.categoryController,
                                      );
                                    },
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(product.productTitle),
                                    Text('${(product.productPrice).toStringAsFixed(2)} €'),
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

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        final languageProvider = Provider.of<LanguageProvider>(context); // Zugriff auf den LanguageProvider
        final String language = languageProvider.language; // Aktuelle Sprache abrufen

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(textFiles[language]![36]),
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        lightThemeList[0],
                        lightThemeList[1],
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(sitesPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Produktname
                        CustomTextField(
                          controller: productProvider.nameController,
                          eventTextfieldItem: EventTextfieldItem(
                            eventTextfieldHintText: textFiles[language]![37],
                          ),
                          onChanged: (value) {},
                        ),
                        const SizedBox(height: 10),
                        // Produktpreis
                        CustomTextField(
                          controller: productProvider.priceController,
                          onChanged: (value) {},
                          eventTextfieldItem: EventTextfieldItem(
                            eventTextfieldHintText: textFiles[language]![38],
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Produktkategorie
                        CustomTextField(
                          controller: productProvider.categoryController,
                          eventTextfieldItem: EventTextfieldItem(
                            eventTextfieldHintText: textFiles[language]![39],
                          ),
                          onChanged: (value) {},
                        ),
                        const SizedBox(height: 30),
                        _addButton(context, productProvider, language),
                        const SizedBox(height: 30),
                        Text(textFiles[language]![40]),
                        const SizedBox(height: 10),
                        _cardCategory(productProvider, language),
                        const SizedBox(height: bigBttnHeight),
                        BigButton(
                          buttonName: textFiles[language]![41],
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, "/order");
                          },
                        ),
                        const SizedBox(height: bottomSafeArea),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
