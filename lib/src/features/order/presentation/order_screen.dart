import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/core/presentation/theme_container.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:cash_track/src/features/general_widgets/presentation/outlined_big_button.dart';
import 'package:cash_track/src/features/order/data/category_data_map.dart';

import 'package:cash_track/src/features/order/presentation/layout_widgets/category_row.dart';
import 'package:cash_track/src/features/order/presentation/layout_widgets/monitor_view.dart';

import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final bool _isSelect = true;
  final int _deskNumber = 1; //test

  final bool _isContainerEmpty = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSelect ? Text('Tischnummer: $_deskNumber') : const Text(''),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const MonitorView(),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  height: 40,
                  width: 200,
                  child: OutlinedBigButton(
                    buttonName: 'Tischnummer wählen',
                    onPressed: () {},
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Expanded(
                  child: CategoryRow(
                    category: categoryData,
                  ),
                ),
                SizedBox(
                  height: bigBttnHeight,
                  child: BigButton(
                    buttonName: 'Bestellen',
                    backgroundColor: _isContainerEmpty ? Colors.grey.shade300 : orangeColor,
                    textColor: _isContainerEmpty ? Colors.grey.shade500 : Colors.black,
                    onPressed: _isContainerEmpty ? null : () {},
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
