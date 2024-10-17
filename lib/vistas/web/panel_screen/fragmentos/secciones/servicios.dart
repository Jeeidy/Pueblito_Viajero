import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/widgets/textfield_mirador.dart';

import '../../../../../provider/screen_iniciar_sesion_provider.dart';
import '../../../../../provider/panel_mirador_provider.dart';
import '../../widgets/editar.dart';

class ServiciosSeccion extends StatelessWidget {
  const ServiciosSeccion({super.key});

  @override
  Widget build(BuildContext context) {
    final miradorProvider = Provider.of<PanelMiradorProvider>(context);
    final sesionProvider = Provider.of<IniciarSesionProvider>(context);

    final lista_1 = miradorProvider.mirador.servicios;
    final lista_2 = sesionProvider.mirador.servicios;

    if (miradorProvider.serviciosController.text.isEmpty) {
      miradorProvider.serviciosController.text = miradorProvider.mirador.servicios.join('\n');
    }

    return Card(
      elevation: 3,
      color: Colors.grey[300],
      child: Stack(
        children: [
          Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                flex: 1,
                child: Text(
                  'Servicios:',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: miradorProvider.serviciosEdit
                    ? TextFieldServiciosMirador(
                      hintText:
                      lista_1.isEmpty && lista_2.isEmpty
                      ? 'Escriba cada servicio separado por un salto de linea.'
                      : lista_2.isEmpty ? lista_1.join('\n') : lista_2.join('\n'),
                      controller: miradorProvider.serviciosController,
                      focusNode: miradorProvider.serviciosFocusNode,
                    )
                    : lista_1.isEmpty && lista_2.isEmpty
                      ? const Text(
                      'Enliste los servicios que ofrece su mirador.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      )
                      : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: (lista_1.isEmpty ? lista_2 : lista_1)
                          .where((servicio) => servicio != null)
                          .map((servicio) => Text(
                        servicio!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      )
                      ).toList(),
                    ),
                  ),
                )
              ),
            ],
          ),
        ),
          Positioned(
            bottom: 10,
            right: 10,
            child: EditarWidget(
              onEdit: () {
                miradorProvider.cambiarMarcaServiciosEdit();
              },
              onCheck: () {
                miradorProvider.extraerServicios(miradorProvider.serviciosController);
                miradorProvider.cambiarMarcaServicios();
              },
              id: 2,
            )
          )
        ],
      ),
    );
  }
}
