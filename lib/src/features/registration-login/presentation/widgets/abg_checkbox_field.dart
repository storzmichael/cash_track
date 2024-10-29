import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cash_track/src/features/registration-login/application/login_provider.dart';

class AgbCheckboxField extends StatelessWidget {
  final String agbText;
  final String agbLink;

  const AgbCheckboxField({
    super.key,
    required this.agbText,
    required this.agbLink,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: provider.agbAccepted,
          onChanged: (bool? newValue) {
            provider.toggleAgbAccepted(newValue ?? false);
          },
          activeColor: Colors.blue,
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: agbText,
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  text: ' AGB',
                  style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Hier öffnen Sie die AGB-Seite
                      Navigator.pushNamed(context, agbLink);
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
