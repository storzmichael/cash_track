import 'package:cash_track/src/features/registration-login/application/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cash_track/src/config/config_colors.dart';

class LoginTextField extends StatelessWidget {
  final String labelName;
  final bool isPassword;
  final TextEditingController controller;
  final Color labelTextColor;
  final double borderRadius;
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
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context, listen: true);

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: SizedBox(
          height: height,
          child: TextField(
            controller: controller,
            obscureText: isPassword ? provider.obscureText : false,
            decoration: InputDecoration(
              filled: true,
              fillColor: backgroundColor,
              border: InputBorder.none,
              labelText: labelName,
              labelStyle: TextStyle(color: labelTextColor),
              floatingLabelStyle: TextStyle(color: labelTextColor),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: EdgeInsets.symmetric(
                vertical: (height - 20) / 2,
                horizontal: 12,
              ),
              prefixIcon: prefixIcon != null
                  ? IconTheme(
                      data: IconThemeData(color: labelTextColor),
                      child: prefixIcon!,
                    )
                  : null,
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        provider.obscureText ? Icons.visibility_off : Icons.visibility,
                        color: labelTextColor,
                      ),
                      onPressed: provider.toggleObscureText,
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
