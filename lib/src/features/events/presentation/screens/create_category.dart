import 'dart:developer';

import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/features/events/application/product_provider.dart';
import 'package:cash_track/src/features/events/domain/event_textfield_item.dart';
import 'package:cash_track/src/features/general_widgets/presentation/outlined_big_button.dart';
import 'package:cash_track/src/features/order/presentation/layout_widgets/category_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cash_track/src/features/general_widgets/presentation/custom_txt_field.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/settings/application/language_provider.dart'; // Importiere den LanguageProvider

class CreateCategoryScreen extends StatelessWidget {
  const CreateCategoryScreen({super.key});

  // Widget für den "Hinzufügen"-Button
  Widget _addButton(BuildContext context, ProductProvider productProvider, String language) {
    return Center(
      child: SizedBox(
        width: 200,
        height: bigBttnHeight,
        child: OutlinedBigButton(
            buttonName: textFiles[language]![15], // Der Button-Name bleibt immer ein String
            onPressed: () {
              // Füge die Kategorie hinzu und lösche anschließend den Text im Eingabefeld
              productProvider.addCategory(productProvider.categoryController.text);
              productProvider.categoryController.clear();
              log(productProvider.categoryProductMap.toString());
            }),
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
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(textFiles[language]![90]), // Titel der AppBar aus der Sprachdatei
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        lightThemeList[0], // Erste Farbfarbe für den Hintergrund
                        lightThemeList[1], // Zweite Farbfarbe für den Hintergrund
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(sitesPadding), // Abstand für das Layout
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Produktkategorie Eingabe
                        CustomTextField(
                          isFocused: false,
                          controller: productProvider.categoryController, // Controller für das Eingabefeld
                          eventTextfieldItem: EventTextfieldItem(
                            eventTextfieldHintText:
                                textFiles[language]![39], // Textfeld Hinweistext aus der Sprachdatei
                          ),
                          onChanged: (value) {}, // Listener für Eingabeveränderungen
                        ),
                        const SizedBox(height: 30), // Abstand zwischen den Eingabefeldern

                        // "Hinzufügen"-Button
                        _addButton(context, productProvider, language),

                        Expanded(child: SizedBox()), // Platzhalter für weitere Elemente

                        // Anzeige der bestehenden Kategorien
                        Consumer<ProductProvider>(
                          builder: (context, productProvider, child) {
                            return productProvider.categories.isNotEmpty
                                ? SizedBox(
                                    height: gridheight, // Höhe der Kategorie-Zeile
                                    child: CategoryRow(
                                      categories: productProvider.categories, // Übergebe die Liste der Kategorien
                                    ),
                                  )
                                : SizedBox(
                                    height: gridheight,
                                    width: double.infinity,
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        textFiles[languageProvider.language]![
                                            7], // Hinweistext, wenn keine Kategorien vorhanden sind
                                        style: Theme.of(context).textTheme.labelLarge, // Styling für den Text
                                      ),
                                    ),
                                  );
                          },
                        ),

                        const SizedBox(height: bigBttnHeight), // Abstand zum nächsten Button

                        // Button zum Zurückgehen zum Order-Screen
                        BigButton(
                          buttonName: textFiles[language]![41], // Button-Name aus der Sprachdatei
                          onPressed: () {
                            isInEditing = false; // Setze den Bearbeitungsmodus auf "false"
                            Navigator.pushReplacementNamed(context, "/order"); // Wechsel zu /order Screen
                          },
                        ),
                        const SizedBox(height: bottomSafeArea), // Abstand zur unteren Bildschirmkante
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
