import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:flutter/material.dart';

// A ListView widget to display unpaid items
class ListViewUnpaid extends StatefulWidget {
  const ListViewUnpaid({super.key});

  @override
  State<ListViewUnpaid> createState() => _ListViewUnpaidState();
}

class _ListViewUnpaidState extends State<ListViewUnpaid> {
  final double _containerHeight = 300; // Set height of the container

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius), // Rounded corners for the top left
          topRight: Radius.circular(borderRadius), // Rounded corners for the top right
        ),
        color: textFieldColor, // Background color for the container
      ),
      height: _containerHeight, // Apply the defined height
      child: Padding(
        padding: const EdgeInsets.all(allSitesPadding), // Padding for the inner content
        child: ListView.builder(
          itemCount: 5 /*desksItems.length*/, // Number of items in the list (dummy value for now)
          itemBuilder: (context, index) {
            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    children: [
                      // TODO: variable for the quantity
                      Text('1x'), // Static quantity, replace with dynamic value
                      SizedBox(
                        width: 8,
                      ),
                      // TODO: variable for the item name
                      Text('Cola'), // Static item name, replace with dynamic value
                      Expanded(child: SizedBox()), // Expands the space between item name and price
                      // TODO: variable for the price
                      Text('2,50 €'), // Static price, replace with dynamic value
                    ],
                  ),
                ),
                if (index <= 100 /*desksItems.length*/) // Limit condition for displaying the divider
                  const Divider(
                    thickness: 0.3, // Thickness of the divider
                    color: blackColor, // Color of the divider
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
