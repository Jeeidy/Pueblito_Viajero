import 'package:flutter/material.dart';
import 'package:pueblito_viajero/vistas/android/home/fragmentos/secciones/mirador_contacto.dart';
import 'package:pueblito_viajero/vistas/android/home/fragmentos/secciones/mirador_horario.dart';
import 'package:pueblito_viajero/vistas/android/home/fragmentos/secciones/mirador_servicios.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/widgets/card_mapa_stub.dart';
import '../../../../../modelos/mirador_modelo.dart';
import 'mirador_titulo_slider_descripcion.dart';

class InformacionMirador extends StatelessWidget {
  final MiradorModel mirador;

  const InformacionMirador({required this.mirador, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: MiradorTituloSliderDescripcion(mirador: mirador),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MiradorContacto(mirador: mirador),
                    const SizedBox(height: 15),
                    CardGoogleMaps(src: mirador.mapa, name: mirador.name),
                    const SizedBox(height: 15),
                    MiradorHorario(mirador: mirador),
                    MiradorServicios(mirador: mirador)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

