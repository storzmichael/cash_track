import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/data/firebase_functions.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/events/application/button_funktions.dart';
import 'package:cash_track/src/features/events/application/product_provider.dart';
import 'package:cash_track/src/features/events/data/event_textfield_data.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:cash_track/src/features/general_widgets/presentation/custom_txt_field.dart';
import 'package:cash_track/src/features/order/application/order_provider.dart';
import 'package:cash_track/src/features/order/domain/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cash_track/src/features/settings/application/language_provider.dart';

class TextFieldEvent extends StatelessWidget {
  const TextFieldEvent({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final String language = languageProvider.language;

    final TextEditingController codeController = TextEditingController();
    final TextEditingController eventNameController = TextEditingController();

    final eventTextfieldDatas = getEventTextfieldDatas(context);

    // ValueNotifier für den Button-Status
    ValueNotifier<bool> isButtonEnabled = ValueNotifier(false);

    // Listener für die Textfelder
    void _updateButtonState() {
      isButtonEnabled.value = eventNameController.text.isNotEmpty && codeController.text.isNotEmpty;
    }

    eventNameController.addListener(_updateButtonState);
    codeController.addListener(_updateButtonState);

    // Zugriff auf den ProductProvider
    final productProvider = Provider.of<ProductProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);

    return Column(
      children: [
        // Event Name:
        CustomTextField(
          eventTextfieldItem: eventTextfieldDatas[0],
          controller: eventNameController,
          onChanged: (value) {
            _updateButtonState();
          },
        ),
        const SizedBox(height: 12),

        // Code
        CustomTextField(
          eventTextfieldItem: eventTextfieldDatas[3],
          controller: codeController,
          onChanged: (value) {
            _updateButtonState();
          },
        ),
        const SizedBox(height: 32),

        // Generiere neuen Code
        BigButton(
          buttonName: textFiles[language]![43],
          onPressed: () {
            String newCode = generateRandomCode(15);
            codeController.text = newCode;
            _updateButtonState();
          },
        ),
        const Expanded(child: SizedBox()),

        // Erstelle neues Event
        ValueListenableBuilder<bool>(
          valueListenable: isButtonEnabled,
          builder: (context, isEnabled, child) {
            return BigButton(
              buttonName: textFiles[language]![44],
              onPressed: isEnabled
                  ? () async {
                      try {
                        Map<String, List> categoryData = productProvider.categoryData;
                        List<String> orderDeskNumbers = orderProvider.orderDeskNumbers;
                        Map<String, List<ProductItem>> orderDeskProducts = orderProvider.orderDeskProducts;
                        List<ProductItem> paidProducts = orderProvider.cashoutProducts;
                        List<String> tables = orderProvider.tables;

                        await setNewEvent(
                          eventNameController.text,
                          codeController.text,
                          categoryData,
                          orderDeskNumbers,
                          orderDeskProducts,
                          paidProducts,
                          tables,
                        );

                        Navigator.pushReplacementNamed(context, "/createProducts");
                      } catch (e) {
                        print(e);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Fehler beim Erstellen des Events: $e')),
                        );
                      }
                    }
                  : null,
            );
          },
        ),
        SizedBox(height: bottomSafeArea),
      ],
    );
  }
}
