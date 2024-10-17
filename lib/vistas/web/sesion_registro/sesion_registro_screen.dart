import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/vistas/web/sesion_registro/fragmentos/crear_cuenta_fragmento.dart';
import 'package:pueblito_viajero/vistas/web/sesion_registro/fragmentos/inicio_sesion_fragmento.dart';
import 'package:pueblito_viajero/vistas/web/sesion_registro/fragmentos/text_logo_fragmento.dart';

import '../../../provider/screen_iniciar_sesion_provider.dart';

class WebSesionRegistroScreen extends StatelessWidget {
  const WebSesionRegistroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sesionProvider = Provider.of<IniciarSesionProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          children: [
            Expanded(
              child: Container(
                color: Colors.white,
                child: sesionProvider.authProcess
                ? const TextLogoFragmento()
                : const InicioSesionFragmento(),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: sesionProvider.authProcess
                ? const CrearCuentaFragmento()
                : const TextLogoFragmento(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}