import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:flutter/material.dart';

class ButtonCategoryCustom extends StatelessWidget {
  final String categoryTitle;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double height;
  final double width;
  final bool fontInBold;
  final Widget? child;

  const ButtonCategoryCustom({
    super.key,
    required this.categoryTitle,
    required this.onPressed,
    this.backgroundColor = greenColor,
    this.textColor = Colors.white,
    this.borderRadius = borderRadiusSmallButton,
    this.height = double.infinity,
    this.width = 104,
    this.fontInBold = false,
    this.child,
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
          child: Text(
            categoryTitle,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: textColor,
                  fontWeight: fontInBold ? FontWeight.bold : FontWeight.normal,
                ),
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';

// class ButtonCategoryCustom extends StatelessWidget {
//   final String categoryTitle;
//   final bool fontInBold;
//   final VoidCallback onPressed;

//   const ButtonCategoryCustom({
//     super.key,
//     required this.categoryTitle,
//     required this.fontInBold,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       child: Text(
//         categoryTitle,
//         style: TextStyle(
//           fontWeight: fontInBold ? FontWeight.bold : FontWeight.normal,
//         ),
//       ),
//     );
//   }
// }
