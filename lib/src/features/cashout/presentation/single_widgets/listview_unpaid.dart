import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:flutter/material.dart';

class ListViewUnpaid extends StatefulWidget {
  const ListViewUnpaid({super.key});

  @override
  State<ListViewUnpaid> createState() => _ListViewUnpaidState();
}

class _ListViewUnpaidState extends State<ListViewUnpaid> {
  final double _containerHeight = 300;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
        color: Color.fromARGB(255, 170, 170, 170),
      ),
      height: _containerHeight,
      child: Padding(
        padding: const EdgeInsets.all(allSitesPadding),
        child: ListView.builder(
          itemCount: 5 /*desksItems.length*/,
          itemBuilder: (context, index) {
            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    children: [
                      Text('1x'),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Cola'),
                      Expanded(child: SizedBox()),
                      Text('2,50 €'),
                    ],
                  ), // Mit Listeneintrag füllen
                ),
                if (index <= 100 /*desksItems.length*/)
                  const Divider(
                    thickness: 0.3,
                    color: blackColor,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
