import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/utils/custom/custom_colors.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/fragmentos/panel_mirador.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/fragmentos/panel_oferta_laboral.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/fragmentos/panel_inicio_fragmento.dart';
import '../../../provider/panel_inicio_provider.dart';
import '../../../provider/screen_iniciar_sesion_provider.dart';
import 'fragmentos/panel_eventos.dart';
import 'fragmentos/panel_perfil.dart';

class PantallaWebPanel extends StatelessWidget {
  const PantallaWebPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final panelProvider = Provider.of<PanelProvider>(context);
    var screens = [
      const PanelCentralFragmento(),
      const PanelMirador(),
      const PanelEventos(),
      const PanelOfertaLaboral(),
      const PanelPerfil()
    ];

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Expanded(
                flex: 1,
                child: CardBarraSuperior()
              ),
              Expanded(
                flex: 6,
                child: Container(
                  color: AppColors.blanco,
                  child: Row(
                    children: <Widget>[
                      const Expanded(
                        flex: 1,
                        child: CardMenuIzquierdo()
                      ),
                      Expanded(
                        flex: 6,
                        child: screens[panelProvider.screen],
                      ),
                    ],
                  ),
                )
              )
            ],
          ),
        ),
      )
    );
  }
}


class CardBarraSuperior extends StatelessWidget {
  const CardBarraSuperior({super.key});

  @override
  Widget build(BuildContext context) {
    final panelProvider = Provider.of<PanelProvider>(context);
    final sesionProvider = Provider.of<IniciarSesionProvider>(context);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color:AppColors.azulClaro,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Center(
                  child: Image.asset('assets/logo.png', height: 65),
                )
            ),
            Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Center(
                    child: Text(
                      'PANEL ADMINISTRATIVO',
                      style: GoogleFonts.inter(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        letterSpacing: 1,
                        height: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.home_outlined, size: 37, color: AppColors.amarilloSupernova),
                      onPressed: () {
                        panelProvider.actualizarPantalla(0);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.person_2_outlined, size: 37, color: AppColors.amarilloSupernova),
                      onPressed: () {
                        panelProvider.actualizarPantalla(4);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.power_settings_new_outlined, size: 37, color: AppColors.amarilloSupernova),
                      onPressed: () {
                        sesionProvider.logout(context);
                      },
                    ),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}


class CardMenuIzquierdo extends StatelessWidget {
  const CardMenuIzquierdo({super.key});

  @override
  Widget build(BuildContext context) {
    final panelProvider = Provider.of<PanelProvider>(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.azulClaro,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  panelProvider.actualizarPantalla(0);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: panelProvider.screen == 0 ? Colors.blue : null,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[300]!,
                        width: 0.7,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Inicio',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        letterSpacing: 1,
                        height: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  panelProvider.actualizarPantalla(1);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: panelProvider.screen == 1 ? Colors.blue : null,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[300]!,
                        width: 0.7,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Mirador',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        letterSpacing: 1,
                        height: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  panelProvider.actualizarPantalla(2);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: panelProvider.screen == 2 ? Colors.blue : null,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[300]!,
                        width: 0.7,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Eventos',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        letterSpacing: 1,
                        height: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  panelProvider.actualizarPantalla(3);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: panelProvider.screen == 3 ? Colors.blue : null,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[300]!,
                        width: 0.7,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Oferta Laboral',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        letterSpacing: 1,
                        height: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  panelProvider.actualizarPantalla(4);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: panelProvider.screen == 4 ? Colors.blue : null,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Perfil',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        letterSpacing: 1,
                        height: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
