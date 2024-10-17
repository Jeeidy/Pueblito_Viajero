import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/utils/custom/custom_colors.dart';
import '../../../provider/screen_servicios_provider.dart';
import '../../widgets/boton_personalizable.dart';
import '../../widgets/boton_sesion_redes.dart';

class PantallaServicios extends StatelessWidget {
  const PantallaServicios({super.key});

  @override
  Widget build(BuildContext context) {
    final serviciosProvider = Provider.of<ServiciosProvider>(context);
    return Scaffold(
        backgroundColor: AppColors.blanco,
        body: Center(
          child: Card(
            elevation: 3,
            color: AppColors.gris,
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'PUEBLITO',
                        style: GoogleFonts.inter(
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 3,
                          height: 1.03,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'VIAJERO',
                        style: GoogleFonts.inter(
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 3,
                          height: 1.03,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  BotonComun(
                    color: AppColors.verdeDivertido,
                    text: 'INICIAR SESIÓN',
                    onPressed: (){
                      serviciosProvider.irAPaginaIniciarSesion(context);
                    }
                  ),
                  BotonComun(
                    color: AppColors.verdeDivertido,
                    text: 'CREAR CUENTA',
                    onPressed: (){
                      serviciosProvider.irAPaginaCrearCuenta(context);
                    }
                  ),
                  const Divider(height: 40),
                  const Text(
                    'Usar otra cuenta:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  const SizedBox(height: 5),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BotonRedes(
                        text: 'Iniciar sesión con Google',
                        icon: Icons.g_translate_outlined,
                        onPressed: (){},
                        type: 'google',
                      ),
                      BotonRedes(
                        text: 'Iniciar sesión con Facebook',
                        icon: Icons.facebook_outlined,
                        onPressed: (){},
                        type: 'facebook',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      );
  }
}