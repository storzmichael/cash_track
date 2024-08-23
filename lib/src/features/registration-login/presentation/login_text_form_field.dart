import 'package:cash_track/src/config/config_colors.dart';
import 'package:flutter/material.dart';

class LoginTextFormField extends StatefulWidget {
  final String labelName;

  final bool isPassword;
  final bool isUsername;

  final TextEditingController controller;

  final Color borderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final Color labelTextColor;

  const LoginTextFormField({
    super.key,
    required this.labelName,
    this.isUsername = false,
    this.isPassword = false,
    required this.controller,
    this.borderColor = Colors.grey,
    this.focusedBorderColor = orangeColor,
    this.errorBorderColor = Colors.red,
    this.labelTextColor = Colors.black,
  });

  @override
  // ignore: library_private_types_in_public_api
  _LoginTextFormFieldState createState() => _LoginTextFormFieldState();
}

class _LoginTextFormFieldState extends State<LoginTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.focusedBorderColor),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.errorBorderColor),
        ),
        labelText: widget.labelName,
        labelStyle: TextStyle(color: widget.labelTextColor),
        floatingLabelStyle: TextStyle(color: widget.focusedBorderColor),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Bitte gib ein ${widget.labelName} ein';
        }
        if (!widget.isPassword && !widget.isUsername) {
          final emailRegex = RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
          if (!emailRegex.hasMatch(value)) {
            return 'Bitte gib eine gültige Email ein';
          }
        }
        if (widget.isUsername) {
          if (value.length < 6) {
            return 'Username muss mindesten 6 Zeichen lang sein';
          }
        }
        {
          if (value.length < 6) {
            return 'Passworts muss mindesten 6 Zeichen lang sein';
          }
        }
        return null;
      },
    );
  }
}