import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/utils/custom/custom_colors.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/fragmentos/panel_mirador.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/fragmentos/panel_oferta_laboral.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/fragmentos/secciones/barra_superiror_fragmento.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/fragmentos/panel_inicio_fragmento.dart';

import '../../../provider/panel_inicio_provider.dart';
import 'fragmentos/panel_eventos.dart';
import 'fragmentos/panel_perfil.dart';
import 'fragmentos/secciones/menu_izquierdo_fragmento.dart';

class PanelScreen extends StatelessWidget {
  const PanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final panelProvider = Provider.of<PanelProvider>(context);
    var screens = [const PanelCentralFragmento(), const PanelMirador(), const PanelEventos(),
                   const PanelOfertaLaboral(), const PanelPerfil()];

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
