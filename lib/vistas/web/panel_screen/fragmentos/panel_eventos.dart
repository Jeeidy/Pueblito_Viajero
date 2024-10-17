import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/widgets/calendario_interactivo.dart';
import '../../../../provider/panel_eventos_provider.dart';
import '../../../../utils/custom/custom_colors.dart';
import '../../../android/crear_cuenta/widgets/textfield_personalizable.dart';
import '../../../android/home/fragmentos/eventos.dart';
import '../../../widgets/boton_personalizable.dart';
import '../../../widgets/textfield_descripcion.dart';

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


class FormularioEventos extends StatelessWidget {
  const FormularioEventos({super.key});

  @override
  Widget build(BuildContext context) {
    final eventosProvider = Provider.of<EventosProvider>(context);
    var image = eventosProvider.evento.image;

    return Card(
      elevation: 3,
      color: Colors.grey[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFieldPersonalizable(
                    labelText: 'Nombre del evento',
                    hintText: 'Nombre del evento',
                    icon: Icons.add_business,
                    controller: eventosProvider.nombreController,
                    keyboard: 'otro',
                    focusNode: eventosProvider.nombreFocusNode,
                    type: '2',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFieldPersonalizable(
                    labelText: 'Precio',
                    hintText: 'Precio',
                    icon: Icons.monetization_on_outlined,
                    controller: eventosProvider.precioController,
                    keyboard: 'num',
                    focusNode: eventosProvider.precioFocusNode,
                    type: '2',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFieldPersonalizable(
                    labelText: 'Hora',
                    hintText: 'Hora',
                    icon: Icons.access_time_outlined,
                    controller: eventosProvider.horaController,
                    keyboard: 'otro',
                    focusNode: eventosProvider.horaFocusNode,
                    type: '2',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFieldDescripcion(
                      hintText: 'Descripción del evento',
                      controller: eventosProvider.descripcionController,
                      focusNode: eventosProvider.descripcionFocusNode
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
                  child: SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                            child: Center(
                              child: image == null
                              ? const Icon(
                                Icons.post_add_outlined,
                                color: AppColors.azulClaro,
                                size: 120
                              )
                              : Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: AppColors.azulClaro,
                                    width: 4.0,
                                  ),
                                ),
                                child: ClipRect(
                                  child: Image.memory(image as Uint8List, fit: BoxFit.cover)
                                ),
                              ),
                            )
                        ),
                        Expanded(
                          child: BotonComun(
                            color: AppColors.azulClaro,
                            text: 'Cargar poster',
                            onPressed: (){
                              eventosProvider.pickImageFromGallery();
                            }
                          )
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: eventosProvider.isLoading
                  ? const Center(child: CircularProgressIndicator(color: AppColors.azulClaro))
                  : BotonComun(
                    color: AppColors.azulClaro,
                    text: 'Cargar evento',
                    onPressed: () async {
                      await eventosProvider.actualizarEvento(context);
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}