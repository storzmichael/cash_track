import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  int _currentIndex = 0; // Der aktuelle Index der Navigation

  int get currentIndex => _currentIndex; // Gibt den aktuellen Index zurück

  void setCurrentIndex(int index) {
    _currentIndex = index; // Setzt den neuen Index
    notifyListeners(); // Benachrichtigt die UI über die Änderung
  }
}
