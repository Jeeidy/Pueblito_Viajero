import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/widgets/textfield_mirador.dart';

import '../../../../provider/screen_iniciar_sesion_provider.dart';
import '../../../../provider/panel_mirador_provider.dart';

class TextContacto extends StatelessWidget {
  final String label;
  final int id;
  const TextContacto({super.key, required this.label, required this.id});

  @override
  Widget build(BuildContext context) {
    final miradorProvider = Provider.of<PanelMiradorProvider>(context);
    final sesionProvider = Provider.of<IniciarSesionProvider>(context);

    final direccion = sesionProvider.mirador.address;
    final direccion_2 = miradorProvider.mirador.address;
    final celular = sesionProvider.mirador.phone;
    final celular_2 = miradorProvider.mirador.phone;
    final correo = sesionProvider.mirador.email;
    final correo_2 = miradorProvider.mirador.email;
    final instagram = sesionProvider.mirador.instagram;
    final instagram_2 = miradorProvider.mirador.instagram;
    final facebook = sesionProvider.mirador.facebook;
    final facebook_2 = miradorProvider.mirador.facebook;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        id == 1
        ? miradorProvider.contactoEdit
          ? Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
            child: TextFieldNombreMirador(
            hintText:
            direccion == '' && direccion_2 == ''
            ? 'Dirección de contacto.'
            : direccion_2 == '' ? direccion : direccion_2,
            controller: miradorProvider.addressController,
            focusNode: miradorProvider.addressFocusNode,
            keyboardType: TextInputType.text,
            ),
          )
          : Text(
            direccion == '' && direccion_2 == ''
            ? 'Dirección de contacto.'
            : direccion_2 == '' ? direccion : direccion_2,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
          ),
        )
      : id == 2
      ? miradorProvider.contactoEdit
        ? Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
          child: TextFieldNombreMirador(
            hintText:
            celular == '' && celular_2 == ''
            ? 'Celular de contacto.'
            : celular_2 == '' ? celular : celular_2,
            controller: miradorProvider.phoneController,
            focusNode: miradorProvider.phoneFocusNode,
            keyboardType: TextInputType.text,
          ),
        )
        : Text(
          celular == '' && celular_2 == ''
          ? 'Celular de contacto.'
          : celular_2 == '' ? celular : celular_2,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        )
      : id == 3
      ? miradorProvider.contactoEdit
        ? Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
          child: TextFieldNombreMirador(
            hintText:
            correo == '' && correo_2 == ''
            ? 'Correo electrónico.'
            : correo_2 == '' ? correo : correo_2,
            controller: miradorProvider.emailController,
            focusNode: miradorProvider.emailFocusNode,
            keyboardType: TextInputType.text,
          ),
        )
        : Text(
          correo == '' && correo_2 == ''
          ? 'Correo electrónico.'
          : correo_2 == '' ? correo : correo_2,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        )
      : id == 4
      ? miradorProvider.contactoEdit
        ? Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
          child: TextFieldNombreMirador(
            hintText:
            instagram == '' && instagram_2 == ''
            ? 'Instagram.'
            : instagram_2 == '' ? instagram : instagram_2,
            controller: miradorProvider.instagramController,
            focusNode: miradorProvider.instagramFocusNode,
            keyboardType: TextInputType.text,
          ),
        )
        : Text(
          instagram == '' && instagram_2 == ''
          ? 'Instagram.'
          : instagram_2 == '' ? instagram : instagram_2,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        )
      : id == 5
      ? miradorProvider.contactoEdit
        ? Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
          child: TextFieldNombreMirador(
            hintText:
            facebook == '' && facebook_2 == ''
            ? 'Facebook.'
            : facebook_2 == '' ? facebook : facebook_2,
            controller: miradorProvider.facebookController,
            focusNode: miradorProvider.facebookFocusNode,
            keyboardType: TextInputType.text,
          ),
        )
        : Text(
          facebook == '' && facebook_2 == ''
          ? 'Facebook.'
          : facebook_2 == '' ? facebook : facebook_2,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        )
      : const SizedBox(),
      ],
    );
  }
}
