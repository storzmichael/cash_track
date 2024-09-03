import 'package:cash_track/src/config/config_colors.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tischnummer: ${desksItems.keys}'),
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
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  height: 200,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      color: greyColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      color: greyColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [const Text('Gesamt'), Text(_orderSum)],
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
                  height: 40,
                  child: BigButton(
                    buttonName: 'Bezahlung abschließen',
                    backgroundColor: _isContainerEmpty ? Colors.grey.shade300 : orangeColor,
                    textColor: _isContainerEmpty ? Colors.grey.shade500 : Colors.black,
                    onPressed: _isContainerEmpty ? null : () {},
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Ausstehend',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
