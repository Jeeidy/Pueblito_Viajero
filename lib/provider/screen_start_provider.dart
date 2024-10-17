import 'package:flutter/material.dart';

class StartProvider with ChangeNotifier {
  void irAPaginaInformacion(BuildContext context) {
    Navigator.pushNamed(context, '/informacion');
  }

  void irAPaginaServicios(BuildContext context) {
    Navigator.pushNamed(context, '/servicios');
  }
}