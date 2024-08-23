import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/core/presentation/theme_container.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:cash_track/src/features/general_widgets/presentation/outlined_big_button.dart';
import 'package:cash_track/src/features/order/presentation/layout_widgets/product_grid.dart';
import 'package:cash_track/src/features/order/presentation/single_widgets/button_category_custom.dart';

import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final bool isSelect = true;
  final int _deskNumber = 1;
  final String _orderSum = '2,50 €';
  final int _itemCount = 4;

  final bool _isContainerEmpty = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSelect ? Text('Tischnummer: $_deskNumber') : const Text(''),
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: SizedBox(
                        height: 160,
                        child: Container(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      flex: 1,
                      child: SizedBox(
                        height: 160,
                        child: Container(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: Container(
                    color: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [const Text('Gesamt'), Text(_orderSum)],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: 200,
                  child: OutlinedBigButton(
                    buttonName: 'Tischnummer wählen',
                    onPressed: () {},
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _itemCount,
                    itemBuilder: (context, index) {
                      return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: ButtonCategoryCustom(
                            categoryTitle: 'Kategorie',
                            fontInBold: true,
                          ));
                    },
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const ProductGrid(),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  height: 40,
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
