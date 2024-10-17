import 'dart:developer';
import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/events/application/product_provider.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:cash_track/src/features/order/application/order_provider.dart';
import 'package:cash_track/src/features/order/presentation/layout_widgets/category_row.dart';
import 'package:cash_track/src/features/order/presentation/layout_widgets/monitor_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cash_track/src/features/settings/application/language_provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const int crossAxisCount = 2; // Anzahl der Spalten im GridView
    const double crossAxisSpacing = 24; // Abstand zwischen den Spalten
    const double mainAxisSpacing = 16; // Abstand zwischen den Zeilen
    const double aspectRatio = 2; // Verhältnis von Breite zu Höhe der Tische
    const double gridheight = 379; // Höhe des Grids min. 379

    final orderProvider = Provider.of<OrderProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context); // Zugriff auf den ProductProvider

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Consumer<OrderProvider>(
          builder: (context, orderProvider, child) {
            return orderProvider.isTableSelect
                ? GestureDetector(
                    onTap: () {
                      orderProvider.setTableSelect(false);
                    },
                    child: Text(
                      '${textFiles[languageProvider.language]![3]}: ${orderProvider.deskNumber}',
                    ),
                  )
                : Text(
                    textFiles[languageProvider.language]![46],
                  );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              orderProvider.showSettingButtonDialog(context, languageProvider.language);
            },
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () => orderProvider.showAddButtonDialog(context, languageProvider.language),
            icon: const Icon(Icons.add),
          ),
          const SizedBox(width: 16),
        ],
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MonitorView(),
                    const Expanded(child: SizedBox()),
                    Consumer<OrderProvider>(
                      builder: (context, orderProvider, child) {
                        return orderProvider.isTableSelect
                            ? SizedBox(
                                height: gridheight,
                                child: CategoryRow(
                                  category:
                                      productProvider.categoryData, // Zugriff auf categoryData vom ProductProvider
                                ),
                              )
                            : SizedBox(
                                height: gridheight,
                                child: GridView.builder(
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    crossAxisSpacing: crossAxisSpacing,
                                    mainAxisSpacing: mainAxisSpacing,
                                    mainAxisExtent: bigBttnHeight,
                                  ),
                                  itemCount: orderProvider.tables.length,
                                  itemBuilder: (context, index) {
                                    return AspectRatio(
                                      aspectRatio: aspectRatio,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                                        child: GestureDetector(
                                          onLongPress: () => orderProvider.showDeleteConfirmDialog(
                                            context,
                                            index,
                                            languageProvider.language,
                                          ),
                                          child: SizedBox(
                                            height: bigBttnHeight,
                                            child: BigButton(
                                              backgroundColor: primeryColorLow,
                                              onPressed: () {
                                                orderProvider.setDeskNumber(orderProvider.tables[index]);
                                                orderProvider.addDeskNumber(orderProvider.deskNumber);

                                                print(orderProvider.deskNumber);
                                                log('Zustand Tisch: ${orderProvider.isTableSelect}');
                                                log('Verfügbare Tische: ${orderProvider.tables}');
                                              },
                                              buttonName: orderProvider.tables[index],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                      },
                    ),
                    const SizedBox(height: 24),
                    Consumer<OrderProvider>(
                      builder: (context, orderProvider, child) {
                        return SizedBox(
                          height: bigBttnHeight,
                          child: BigButton(
                            buttonName: textFiles[languageProvider.language]![45], // "Bestellen"-Button
                            backgroundColor:
                                orderProvider.selectedProducts.isNotEmpty ? primeryColor : disabledBttnColor,
                            textColor: orderProvider.selectedProducts.isNotEmpty ? blackColor : disabledTextColor,
                            onPressed: orderProvider.selectedProducts.isNotEmpty
                                ? () {
                                    orderProvider.setTableSelect(false);
                                    orderProvider.setCategorySelect(false);
                                    orderProvider.transferProductsToOrder();
                                    orderProvider.clearMonitor();
                                    log('Zustand Tisch: ${orderProvider.isTableSelect}');
                                    log('Produkte in selectedProducts: ${orderProvider.selectedProducts}');
                                  }
                                : null,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: bottomSafeArea),
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
