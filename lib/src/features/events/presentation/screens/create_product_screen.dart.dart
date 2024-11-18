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

    // Initialisiere die Controller für Name und Preis
    if (product.productTitle.toLowerCase() == "default") {
      productProvider.nameController.clear(); // Leere den Produktnamen
      productProvider.priceController.clear(); // Leere den Produktpreis
    } else {
      productProvider.nameController.text = product.productTitle; // Setze den Produktnamen
      productProvider.priceController.text = product.productPrice.toString(); // Setze den Preis
    }

    String _toCategory = productProvider.toCategory ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(textFiles[language]![36]), // Setzt den Titel der AppBar
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    lightThemeList[0], // Erste Farbe des Farbverlaufs
                    lightThemeList[1], // Zweite Farbe des Farbverlaufs
                  ],
                  begin: Alignment.topCenter, // Start des Farbverlaufs oben
                  end: Alignment.bottomCenter, // Ende des Farbverlaufs unten
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(sitesPadding), // Padding für das Layout
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Zeigt die Kategorie des Produkts an
                    Text(
                      '${textFiles[language]![91]}      $_toCategory',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 10),
                    // Produktname Eingabefeld
                    CustomTextField(
                      controller: productProvider.nameController,
                      eventTextfieldItem: EventTextfieldItem(
                        eventTextfieldHintText: textFiles[language]![37],
                      ),
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 10),
                    // Produktpreis Eingabefeld
                    CustomTextField(
                      controller: productProvider.priceController,
                      onChanged: (value) {},
                      eventTextfieldItem: EventTextfieldItem(
                        eventTextfieldHintText: textFiles[language]![38],
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Button zum Hinzufügen des Produkts
                    _addButton(
                      context,
                      productProvider,
                      language,
                      _toCategory,
                      () {
                        // Aktualisiere das Produkt mit neuen Werten
                        String updatedTitle = productProvider.nameController.text;
                        double updatedPrice =
                            double.tryParse(productProvider.priceController.text.replaceAll(',', '.')) ?? 0.0;

                        ProductItem updatedProduct = ProductItem(
                          productTitle: updatedTitle,
                          productPrice: updatedPrice,
                        );

                        // Produkt aktualisieren
                        productProvider.updateProductItem(
                          _toCategory,
                          index,
                          updatedProduct,
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    Expanded(child: SizedBox()),
                    // Button zum Bestätigen und Weitergehen
                    BigButton(
                      buttonName: textFiles[language]![41],
                      onPressed: () {
                        isInEditing = false;
                        Navigator.pushReplacementNamed(context, "/order");
                      },
                    ),
                    const SizedBox(height: bottomSafeArea), // Abstand zum unteren Rand
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

// Button zum Hinzufügen eines Produkts
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
      height: bigBttnHeight, // Höhe des Buttons
      child: OutlinedBigButton(
        buttonName: textFiles[language]![15], // Button-Name aus der Sprachdatei
        onPressed: () {
          // Überprüfe, ob der Preis korrekt eingegeben wurde
          double? price = double.tryParse(productProvider.priceController.text.replaceAll(',', '.'));
          if (price == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(textFiles[language]![71]), // Fehlermeldung anzeigen
                duration: const Duration(seconds: 2),
              ),
            );
            return;
          }
          onPressedCallback(); // Callback ausführen, um das Produkt hinzuzufügen
          productProvider.nameController.clear(); // Eingabefeld für Name leeren
          productProvider.priceController.clear(); // Eingabefeld für Preis leeren
          Navigator.pop(context); // Zurück zur vorherigen Seite
        },
      ),
    ),
  );
}

// Darstellung eines Produkts als Karte
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
