import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool _obscureText = true;
  bool _agbAccepted = false;

  bool get obscureText => _obscureText;
  bool get agbAccepted => _agbAccepted;

  // Schaltet die Sichtbarkeit des Passworts um
  void toggleObscureText() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  // Schaltet die AGB-Zustimmung um
  void toggleAgbAccepted(bool value) {
    _agbAccepted = value;
    notifyListeners();
  }
}
