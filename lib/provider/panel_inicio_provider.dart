import 'package:flutter/material.dart';

class PanelProvider with ChangeNotifier {
  int screen = 0;
  int currentImageIndex = 0;

  void actualizarPantalla(int valor) {
    screen = valor;
    notifyListeners();
  }
}