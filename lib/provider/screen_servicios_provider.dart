import 'package:flutter/material.dart';

class ServiciosProvider with ChangeNotifier {
  void irAPaginaIniciarSesion(BuildContext context) {
    Navigator.pushNamed(context, '/iniciar_sesion');
  }

  void irAPaginaCrearCuenta(BuildContext context) {
    Navigator.pushNamed(context, '/crear_cuenta');
  }
}