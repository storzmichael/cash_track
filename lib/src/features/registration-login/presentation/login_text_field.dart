import 'package:cash_track/src/config/config_colors.dart';
import 'package:flutter/material.dart';

class LoginTextField extends StatefulWidget {
  final String labelName;
  final bool isPassword;
  final TextEditingController controller;
  final Color labelTextColor;
  final double borderRadius; // Radius für die Ecken
  final Color backgroundColor;
  final double height;
  final Widget? prefixIcon;

  const LoginTextField({
    super.key,
    required this.labelName,
    this.isPassword = false,
    required this.controller,
    this.labelTextColor = whiteColor,
    this.borderRadius = 12,
    this.backgroundColor = textFieldColor,
    this.height = 40,
    this.prefixIcon,
  });

  @override
  _LoginTextFieldState createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius), // Radius für die Ecken
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius), // Radius für die Ecken
        child: SizedBox(
          height: widget.height,
          child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: widget.backgroundColor,
              border: InputBorder.none, // Kein Rahmen
              focusedBorder: InputBorder.none, // Kein Rahmen, wenn im Fokus
              errorBorder: InputBorder.none, // Kein Rahmen bei Fehler
              labelText: widget.labelName,
              labelStyle: TextStyle(color: widget.labelTextColor),
              floatingLabelStyle: TextStyle(color: widget.labelTextColor),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: EdgeInsets.symmetric(vertical: (widget.height - 20) / 2, horizontal: 12),
              prefixIcon: widget.prefixIcon != null
                  ? IconTheme(
                      data: IconThemeData(color: widget.labelTextColor),
                      child: widget.prefixIcon!,
                    )
                  : null,
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        color: widget.labelTextColor,
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,
            ),
            obscureText: widget.isPassword ? _obscureText : false,
          ),
        ),
      ),
    );
  }
}
