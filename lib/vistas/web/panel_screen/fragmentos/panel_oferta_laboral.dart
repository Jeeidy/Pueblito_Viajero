import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/fragmentos/secciones/formulario_oferta_laboral.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/fragmentos/secciones/slider_oferta_laboral.dart';

import '../../../../provider/panel_oferta_laboral_provider.dart';

class PanelOfertaLaboral extends StatelessWidget {
  const PanelOfertaLaboral({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OfertaLaboralProvider(context),
      child: const Column(
        children: [
          Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: SliderOfertaLaboral()
                  ),
                  Expanded(
                      child: FormularioOfertaLaboral()
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
}
