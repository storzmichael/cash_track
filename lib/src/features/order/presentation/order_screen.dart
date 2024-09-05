import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/core/application/navigation_functions.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/order/application/table_functions.dart';
import 'package:cash_track/src/features/order/data/table_list.dart';
import 'package:flutter/material.dart';
import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:cash_track/src/features/order/data/category_data_map.dart';
import 'package:cash_track/src/features/order/presentation/layout_widgets/category_row.dart';
import 'package:cash_track/src/features/order/presentation/layout_widgets/monitor_view.dart';
import 'package:cash_track/src/core/presentation/theme_container.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool isTableSelect = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isTableSelect ? Text('${textFiles[language]![3]}: $deskNumber') : const Text('Tischnummer wählen'),
        actions: [
          IconButton(
            onPressed: () => TableFunctions.showAddButtonDialog(context, language, setState),
            icon: const Icon(Icons.add),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Stack(
        children: [
          const ThemeContainer(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(sitesPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const MonitorView(),
                  const SizedBox(height: 40),
                  isTableSelect
                      ? Expanded(
                          child: CategoryRow(
                            category: categoryData,
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: tables.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: GestureDetector(
                                  onLongPress: () =>
                                      TableFunctions.showDeleteConfirmDialog(context, index, language, setState),
                                  child: SizedBox(
                                    height: bigBttnHeight,
                                    child: BigButton(
                                      backgroundColor: primeryColorLow,
                                      onPressed: () {
                                        setState(() {
                                          deskNumber = tables[index];
                                          isTableSelect = true;
                                        });
                                      },
                                      buttonName: tables[index],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                  SizedBox(
                    height: bigBttnHeight,
                    child: BigButton(
                        buttonName: textFiles[language]![45],
                        backgroundColor: isTableSelect ? primeryColor : disabledBttnColor,
                        textColor: isTableSelect ? blackColor : disabledTextColor,
                        onPressed: isTableSelect
                            ? () {
                                setState(() {
                                  isTableSelect = false;
                                });
                                navigateToCashoutScrenn(context);
                              }
                            : null),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
