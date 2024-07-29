import 'package:flutter/material.dart';

class LoginTextFormField extends StatelessWidget {
  final String labelName;
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;

  const LoginTextFormField({
    super.key,
    required this.labelName,
    required this.hintText,
    this.isPassword = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelName,
        hintText: hintText,
      ),
      obscureText: isPassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $labelName';
        }
        if (!isPassword) {
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
