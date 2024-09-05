import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/core/presentation/theme_container.dart';
import 'package:cash_track/src/features/cashout/presentation/single_widgets/listview_unpaid.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';

import 'package:flutter/material.dart';

class CashoutScreen extends StatefulWidget {
  const CashoutScreen({super.key});

  @override
  State<CashoutScreen> createState() => _CashoutScreenState();
}

class _CashoutScreenState extends State<CashoutScreen> {
  final bool isSelect = true;

  final String _orderSum = '2,50 €';
  final Map<String, List<int>> desksItems = {
    '1': [1, 2, 3],
    '2': [4, 5, 6]
  };

  final bool _isContainerEmpty = true;
  final double _monitorHeight = 200;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${textFiles[language]![3]}: ${desksItems.keys}'),
        actions: const [
          Icon(Icons.settings),
          SizedBox(
            width: 16,
          ),
        ],
      ),
      body: Stack(
        children: [
          const ThemeContainer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: sitesPadding),
                child: Container(
                  height: _monitorHeight,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(monitorBorderRadius),
                    ),
                    color: textFieldColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: sitesPadding),
                child: SizedBox(
                  height: bigBttnHeight,
                  width: double.infinity,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(monitorBorderRadius),
                      ),
                      color: textFieldColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.symmetric(horizontal: textPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text(textFiles[language]![4]), Text(_orderSum)],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  height: bigBttnHeight,
                  child: BigButton(
                    buttonName: textFiles[language]![5],
                    backgroundColor: _isContainerEmpty ? Colors.grey.shade300 : primeryColor,
                    textColor: _isContainerEmpty ? Colors.grey.shade500 : Colors.black,
                    onPressed: _isContainerEmpty ? null : () {},
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                textFiles[language]![6],
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: 8,
              ),
              const Expanded(
                child: ListViewUnpaid(),
              )
            ],
          ),
        ],
      ),
    );
  }
}
