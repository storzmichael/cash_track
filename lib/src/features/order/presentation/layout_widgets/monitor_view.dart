import 'package:cash_track/src/features/order/data/products_list.dart';
import 'package:cash_track/src/features/order/domain/product_item.dart';
import 'package:flutter/material.dart';

class MonitorView extends StatefulWidget {
  const MonitorView({super.key});

  @override
  State<MonitorView> createState() => _MonitorViewState();
}

class _MonitorViewState extends State<MonitorView> {
  final double valueList = 2.50;
  final String orderSum = '2,50 €';
  final List<ProductItem> _orderItems = productsData;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // show OrderSum
            Flexible(
              flex: 2,
              child: SizedBox(
                height: 160,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(8),
                    ),
                    color: Colors.grey,
                  ),
                  child: ListView.builder(
                    itemCount: _orderItems.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          const Text('1x'),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(_orderItems[index].productTitle),
                          const Expanded(child: SizedBox()),
                          Text('${_orderItems[index].productPrice} €'),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 2),
            // show Tablescreen
            Flexible(
              flex: 1,
              child: SizedBox(
                height: 160,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(8),
                    ),
                    color: Colors.grey,
                  ),
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
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              color: Colors.grey,
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text('Gesamt'), Text(orderSum)],
              ),
            ),
          ),
        )
      ],
    );
  }
}
