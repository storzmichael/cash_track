import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/features/events/domain/event_button_item.dart';
import 'package:flutter/material.dart';

class EventButton extends StatelessWidget {
  final EventButtonItem eventButtonItem;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double height;
  final double width;
  final bool fontInBold;

  const EventButton({
    super.key,
    required this.eventButtonItem,
    required this.onPressed,
    this.backgroundColor = orangeColor,
    this.textColor = Colors.black,
    this.borderRadius = borderRadiusSmallButton,
    this.height = 140,
    this.width = 140,
    this.fontInBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.all(5),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                eventButtonItem.eventButtonIcon,
                color: Colors.black,
                size: 40,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                eventButtonItem.eventButtonTitle,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
