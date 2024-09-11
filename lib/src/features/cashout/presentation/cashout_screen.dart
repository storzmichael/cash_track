import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/core/presentation/theme_container.dart';
import 'package:cash_track/src/features/cashout/presentation/single_widgets/listview_unpaid.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:cash_track/src/features/order/data/table_list.dart';

import 'package:flutter/material.dart';

class CashoutScreen extends StatefulWidget {
  const CashoutScreen({super.key});

  @override
  State<CashoutScreen> createState() => _CashoutScreenState();
}

class _CashoutScreenState extends State<CashoutScreen> {
  final bool isSelect = true; // Indicates if an item is selected (currently unused)

  final String _orderSum = '2,50 €'; // Total amount for the order, displayed in the UI

  final bool _isContainerEmpty = true; // Indicates whether the container is empty, affects button state
  final double _monitorHeight = 200; // Height of the container displaying the monitor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Title of the app bar, includes a placeholder for the selected table index
        title: Text('${textFiles[language]![3]}: $tables'), // TODO: Replace $tables with the dynamic table index
        actions: const [
          Icon(Icons.settings), // Settings icon for future navigation
          SizedBox(width: 16), // Space between icons
        ],
      ),
      body: Stack(
        children: [
          const ThemeContainer(), // Provides a background theme with gradient
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: sitesPadding),
                child: Container(
                  height: _monitorHeight, // Sets the height of the monitor container
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(monitorBorderRadius), // Rounded corners for the container
                    ),
                    color: textFieldColor, // Background color of the monitor container
                  ),
                ),
              ),
              const SizedBox(height: 8), // Space between elements
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: sitesPadding),
                child: SizedBox(
                  height: bigBttnHeight, // Height of the button container
                  width: double.infinity, // Full width of the button container
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(monitorBorderRadius), // Rounded corners for the button container
                      ),
                      color: textFieldColor, // Background color of the button container
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.symmetric(horizontal: textPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(textFiles[language]![4]), // Label text from the language file
                          Text(_orderSum), // Displays the total order sum
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24), // Space between elements
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: sitesPadding),
                child: SizedBox(
                  height: bigBttnHeight, // Height of the button
                  child: BigButton(
                    buttonName: textFiles[language]![5], // Button label from the language file
                    backgroundColor: _isContainerEmpty
                        ? Colors.grey.shade300
                        : primeryColor, // Changes color based on container state
                    textColor: _isContainerEmpty
                        ? Colors.grey.shade500
                        : Colors.black, // Changes text color based on container state
                    onPressed: _isContainerEmpty ? null : () {}, // Disables button if container is empty
                  ),
                ),
              ),
              const SizedBox(height: 24), // Space between elements
              Text(
                textFiles[language]![6], // Header text from the language file
                style: Theme.of(context).textTheme.headlineLarge, // Large headline text style
              ),
              const SizedBox(height: 8), // Space between elements
              const Expanded(
                child: ListViewUnpaid(), // Displays a list of unpaid items
              ),
            ],
          ),
        ],
      ),
    );
  }
}
