import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/fragmentos/secciones/calendario_interactivo.dart';
import '../../../../provider/panel_eventos_provider.dart';
import '../../../web/panel_screen/widgets/card_evento.dart';

class EventosFragmento extends StatelessWidget {
  const EventosFragmento({super.key});

  @override
  Widget build(BuildContext context) {
    final eventosProvider = Provider.of<EventosProvider>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      eventosProvider.cargarEventos(context);
    });

    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  'PRÓXIMOS EVENTOS',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: GoogleFonts.inter(
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 30),
                child: CalendarioInteractivo(),
              ),
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
