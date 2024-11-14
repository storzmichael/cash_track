import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/features/events/application/product_provider.dart';
import 'package:cash_track/src/features/events/domain/event_textfield_item.dart';
import 'package:cash_track/src/features/general_widgets/presentation/outlined_big_button.dart';
import 'package:cash_track/src/features/order/domain/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cash_track/src/features/general_widgets/presentation/custom_txt_field.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:cash_track/src/data/lang/app_text.dart';

class CreateProductScreen extends StatelessWidget {
  final ProductItem product;
  final int index;

  const CreateProductScreen({
    super.key,
    required this.product,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    String _toCategory = productProvider.toCategory ?? '';

    return Scaffold(
      appBar: AppBar(
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
                    Text(
                      '${textFiles[language]![91]}      $_toCategory',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
                    const SizedBox(height: 30),
                    _addButton(
                      context,
                      productProvider,
                      language,
                      _toCategory,
                      () {
                        String updatedTitle = productProvider.nameController.text;
                        double updatedPrice =
                            double.tryParse(productProvider.priceController.text.replaceAll(',', '.')) ?? 0.0;

                        ProductItem updatedProduct = ProductItem(
                          productTitle: updatedTitle,
                          productPrice: updatedPrice,
                        );

                        productProvider.updateProductItem(
                          _toCategory,
                          index,
                          updatedProduct,
                        );
                      },
                    ),

                    const SizedBox(height: 30),
                    Text(textFiles[language]![40]),
                    const SizedBox(height: 10),
                    _cardProduct(productProvider, language),
                    const SizedBox(height: bigBttnHeight),
                    Expanded(child: SizedBox()),
                    BigButton(
                      buttonName: textFiles[language]![41],
                      onPressed: () {
                        isInEditing = false;
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
  }
}

Widget _addButton(
  BuildContext context,
  ProductProvider productProvider,
  String language,
  String toCategory,
  void Function() onPressedCallback,
) {
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
          onPressedCallback();
          productProvider.nameController.clear();
          productProvider.priceController.clear();
          Navigator.pop(context);
        },
      ),
    ),
  );
}

Widget _cardProduct(ProductProvider productProvider, String language) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 10.0),
    child: Container(
      height: 100,
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Text('Produktname: ${productProvider.nameController.text}'),
              SizedBox(width: 20),
              Text('Preis: ${productProvider.priceController.text}'),
            ],
          ),
        ],
      ),
    ),
  );
}
