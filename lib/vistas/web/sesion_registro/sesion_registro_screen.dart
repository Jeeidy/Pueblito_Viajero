import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/vistas/web/sesion_registro/fragmentos/crear_cuenta_fragmento.dart';
import 'package:pueblito_viajero/vistas/web/sesion_registro/fragmentos/inicio_sesion_fragmento.dart';
import '../../../provider/screen_iniciar_sesion_provider.dart';
import '../../../utils/custom/custom_colors.dart';
import '../../android/splash/pantalla_splash.dart';

class PantallaWebSesionRegistro extends StatelessWidget {
  const PantallaWebSesionRegistro({super.key});

  @override
  Widget build(BuildContext context) {
    final sesionProvider = Provider.of<IniciarSesionProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.blanco,
        body: Row(
          children: [
            Expanded(
              child: Container(
                color: AppColors.blanco,
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

class TextLogoFragmento extends StatelessWidget {
  const TextLogoFragmento({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/logo.png', height: 250),
        const SizedBox(height: 10),
        const IconoTextSplash()
      ],
    );
  }
}