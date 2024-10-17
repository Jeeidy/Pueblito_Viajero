import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/widgets/editar.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/widgets/textfield_mirador.dart';
import 'package:pueblito_viajero/vistas/widgets/boton_personalizable.dart';

import '../../../../../provider/screen_iniciar_sesion_provider.dart';
import '../../../../../provider/panel_mirador_provider.dart';
import '../../../../../utils/custom/custom_colors.dart';

class TituloImagenSeccion extends StatelessWidget {
  const TituloImagenSeccion({super.key});

  @override
  Widget build(BuildContext context) {
    final miradorProvider = Provider.of<PanelMiradorProvider>(context);
    final sesionProvider = Provider.of<IniciarSesionProvider>(context);

    final name = miradorProvider.mirador.name ?? '';
    final name_2 = sesionProvider.mirador.name ?? '';
    final description = miradorProvider.mirador.description ?? '';
    final description_2 = sesionProvider.mirador.description ?? '';
    final image = miradorProvider.mirador.image;
    final image_2 = sesionProvider.mirador.image ?? '';
    final imagenUrl = miradorProvider.imagenUrl ?? '';

    if (miradorProvider.nameController.text.isEmpty) {
      miradorProvider.nameController.text = miradorProvider.mirador.name;
    }
    if (miradorProvider.descriptionController.text.isEmpty) {
      miradorProvider.descriptionController.text = miradorProvider.mirador.description;
    }

    return Card(
      elevation: 3,
      color: Colors.grey[300],
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Center(
                  child: (image == null && imagenUrl.isEmpty && image_2 == '')
                  ? const Icon(Icons.account_balance_rounded, color: AppColors.azulClaro, size: 120)
                  : Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.azulClaro,
                        width: 4.0,
                      ),
                    ),
                    child: ClipOval(
                      child: miradorProvider.imagenEdit
                        ? Image.memory(image, fit: BoxFit.cover)
                        : miradorProvider.registrarCheck
                          ? Image.network(imagenUrl, fit: BoxFit.cover)
                          : Image.network(image_2, fit: BoxFit.cover),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 25,
                  right: 10,
                  child: EditarWidgetEliminar(
                    id: 1,
                    onEdit: (){
                      miradorProvider.cambiarMarcaImagenEdit();
                      miradorProvider.pickImageFromGallery(context);
                    },
                    onDelete: (){
                      miradorProvider.eliminarImagen();
                    },
                    onCheck: () {
                      miradorProvider.cambiarMarca();
                  }, type: 'imagen',
                  )
                )
              ],
            )
          ),
          Expanded(
            flex: 6,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      miradorProvider.nombreDescripcionEdit
                      ? Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: TextFieldNombreMirador(
                          hintText:
                          name == '' && name_2 == ''
                          ? 'Ingrese nombre del mirador'
                          : name == '' ? name_2.toUpperCase() : name.toUpperCase(),
                          controller: miradorProvider.nameController,
                          focusNode: miradorProvider.nameFocusNode,
                          keyboardType: TextInputType.text,
                        ),
                      )
                      : Text(
                        name == '' && name_2 == ''
                        ? 'Ingrese nombre del mirador'
                        : name == '' ? name_2.toUpperCase() : name.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                          letterSpacing: 1,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.topCenter,
                        child: miradorProvider.nombreDescripcionEdit
                        ? TextFieldDescripcionMirador(
                          hintText:
                          description == '' && description_2 == ''
                          ? 'Ingrese la nueva descripción del mirador.'
                          : description == '' ? description_2.toUpperCase() : description.toUpperCase(),
                          controller: miradorProvider.descriptionController,
                          focusNode: miradorProvider.descriptionFocusNode
                        )
                        :  Text(
                          description == '' && description_2 == ''
                          ? 'Descripción del mirador..'
                          : description == '' ? description_2 : description,
                          textAlign: TextAlign.center,
                          maxLines: 4,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            letterSpacing: 1,
                            height: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 0,
                  child: EditarWidgetHorizontal(
                    onEdit: () {
                      miradorProvider.cambiarMarcaNombreEdit();
                    },
                    onCheck: () {
                      miradorProvider.agregarValor(miradorProvider.nameController, 'name');
                      miradorProvider.agregarValor(miradorProvider.descriptionController, 'description');
                      miradorProvider.cambiarMarcaNombre();
                    },
                  )
                )
              ],
            )
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child:
              miradorProvider.isLoading
              ? const Center(child: CircularProgressIndicator(color: AppColors.azulClaro))
              : BotonComun(
                color: AppColors.azulClaro,
                text: sesionProvider.tieneMirador ? 'Actualizar' : 'Registrar',
                onPressed: () async {
                  sesionProvider.tieneMirador
                    ? await miradorProvider.actualizarMirador(context)
                    : await miradorProvider.registrarMirador(context);
                },
              ),
            )
          ),
        ],
      ),
    );
  }
}
