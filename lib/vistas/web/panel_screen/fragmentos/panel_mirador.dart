import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/fragmentos/secciones/contacto.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/fragmentos/secciones/horario.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/fragmentos/secciones/mirador_foto_titulo_descripsion.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/fragmentos/secciones/servicios.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/widgets/mirador_slider.dart';

import '../../../../provider/screen_iniciar_sesion_provider.dart';
import '../../../../provider/panel_mirador_provider.dart';
import '../widgets/editar.dart';
import '../widgets/card_mapa_stub.dart';


class PanelMirador extends StatelessWidget {
  const PanelMirador({super.key});

  @override
  Widget build(BuildContext context) {
    final miradorProvider = Provider.of<PanelMiradorProvider>(context);

    return Column(
      children: [
        const Expanded(
          flex: 3,
          child: Center(
            child: Text(
              'En este apartado podrás editar la información descriptiva del mirador, por medio del siguiente panel.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          )
        ),
        const Expanded(
          flex: 6,
          child: TituloImagenSeccion()
        ),
        Expanded(
          flex: 10,
          child: Row(
            children: [
              const Expanded(
                flex: 2,
                child: ContactoSeccion()
              ),
              const Expanded(
                flex: 2,
                child: ServiciosSeccion()
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Expanded(child: ImagenesMiradorSeccionWrapper()),
                          Expanded(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Consumer<PanelMiradorProvider>(
                                  builder: (context, provider, child) {
                                    final sesionProvider = Provider.of<IniciarSesionProvider>(context, listen: false);
                                    final mapaSrc = sesionProvider.mirador.mapa.isNotEmpty
                                        ? sesionProvider.mirador.mapa
                                        : provider.mirador.mapa.isNotEmpty
                                        ? provider.mirador.mapa
                                        : '';

                                    return CardGoogleMaps(
                                      src: mapaSrc,
                                      name: provider.mirador.name,
                                    );
                                  },
                                ),
                                Positioned(
                                  bottom: 10,
                                  right: 10,
                                  child: EditarWidgetEliminar(
                                    onEdit: () {
                                      miradorProvider.cambiarMarcaMapaEdit();
                                    },
                                    onCheck: () {
                                      miradorProvider.agregarValor(miradorProvider.mapaController, 'mapa');
                                      miradorProvider.cambiarMarcaMapa();
                                    },
                                    onDelete: () {},
                                    id: 3,
                                    type: 'mapa',
                                  )
                                )
                              ]
                            ),
                          )
                        ],
                      )
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          const HorarioSeccion(),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: EditarWidget(
                              onEdit: () {
                                miradorProvider.cambiarMarcaHorarioEdit();
                              },
                              onCheck: () {
                                miradorProvider.extraerHorarios(
                                    miradorProvider.horario1Controller,
                                    miradorProvider.horario2Controller,
                                    miradorProvider.horario3Controller,
                                    miradorProvider.horario4Controller
                                );
                                miradorProvider.cambiarMarcaHorario();
                              },
                              id: 3,
                            )
                          )
                        ]
                      )
                    ),
                  ],
                )
              ),
            ],
          )
        ),
      ],
    );
  }
}