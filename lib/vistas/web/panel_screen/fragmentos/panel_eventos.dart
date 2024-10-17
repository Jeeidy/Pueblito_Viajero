import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/fragmentos/secciones/calendario_interactivo.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/fragmentos/secciones/formulario_eventos.dart';

import '../../../../provider/panel_eventos_provider.dart';
import '../widgets/card_evento.dart';


class PanelEventos extends StatelessWidget {
  const PanelEventos({super.key});

  @override
  Widget build(BuildContext context) {
    final eventosProvider = Provider.of<EventosProvider>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      eventosProvider.cargarEventos(context);
    });

    return Stack(
      children: [
        const Column(
          children: [
            Expanded(
                flex: 10,
                child: Row(
                  children: [
                    Expanded(
                        child: CalendarioInteractivo()
                    ),
                    Expanded(
                        child: FormularioEventos()
                    ),
                  ],
                )
            ),
          ],
        ),
        if (eventosProvider.selectedEvent != null)
          Positioned(
            child: CardEvento(event: eventosProvider.selectedEvent!),
          ),
      ],
    );
  }
}