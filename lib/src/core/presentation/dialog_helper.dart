import 'package:flutter/cupertino.dart';
import 'package:cash_track/src/config/config_colors.dart';

class DialogHelper {
  // Reusable Cupertino dialog for text input
  static void showTextInputDialog({
    required BuildContext context,
    required String title,
    required String placeholder,
    required String cancelButtonText,
    required String confirmButtonText,
    required Function(String) onConfirm,
    String? initialValue = '', // Optional initial value for the text field
  }) {
    final TextEditingController textController = TextEditingController(text: initialValue);

    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Column(
            children: [
              const SizedBox(height: 16), // Adds spacing between title and content
              CupertinoTextField(
                autofocus: true,
                controller: textController,
                placeholder: placeholder, // Placeholder text
              ),
            ],
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text(cancelButtonText, style: const TextStyle(color: blackColor)), // Cancel button style
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text(confirmButtonText, style: const TextStyle(color: primeryColor)), // Confirm button style
              onPressed: () {
                String inputText = textController.text.trim();
                onConfirm(inputText); // Callback with the entered text
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
