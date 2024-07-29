import 'package:cash_track/src/config/config_colors.dart';
import 'package:flutter/material.dart';

class LoginTextFormField extends StatefulWidget {
  final String labelName;
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;

  const LoginTextFormField({
    super.key,
    required this.labelName,
    required this.hintText,
    this.isPassword = false,
    required this.controller,
    this.borderColor = Colors.grey,
    this.focusedBorderColor = orangeColor,
    this.errorBorderColor = Colors.red,
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
        hintText: widget.hintText,
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
          return 'Please enter your ${widget.labelName}';
        }
        if (!widget.isPassword) {
          final emailRegex = RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
          if (!emailRegex.hasMatch(value)) {
            return 'Please enter a valid email';
          }
        } else {
          if (value.length < 6) {
            return 'Password must be at least 6 characters long';
          }
        }
        return null;
      },
    );
  }
}
