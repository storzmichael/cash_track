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

  Widget _addButton(BuildContext context, ProductProvider productProvider, String language) {
    return Center(
      child: SizedBox(
        width: 200,
        height: bigBttnHeight,
        child: OutlinedBigButton(
          buttonName: textFiles[language]![15],
          onPressed: () {
            productProvider.addCategory(productProvider.categoryController.text);
            productProvider.categoryController.clear();
            log(productProvider.categoryProductMap.toString());
          },
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
            title: Text(textFiles[language]![90]),
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

                        Expanded(child: SizedBox()),
                        Consumer<ProductProvider>(
                          builder: (context, productProvider, child) {
                            return productProvider.categories.isNotEmpty
                                ? SizedBox(
                                    height: gridheight,
                                    child: CategoryRow(
                                      categories:
                                          productProvider.categories, // Zugriff auf categoryData vom ProductProvider
                                    ),
                                  )
                                : SizedBox(
                                    height: gridheight,
                                    width: double.infinity,
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        textFiles[languageProvider.language]![7],
                                        style: Theme.of(context).textTheme.labelLarge,
                                      ),
                                    ),
                                  );
                          },
                        ),

                        const SizedBox(height: bigBttnHeight),

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
      },
    );
  }
}
