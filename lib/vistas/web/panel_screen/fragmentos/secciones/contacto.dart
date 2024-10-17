import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/widgets/text_contacto.dart';

import '../../../../../provider/panel_mirador_provider.dart';
import '../../widgets/editar.dart';

class ContactoSeccion extends StatelessWidget {
  const ContactoSeccion({super.key});

  @override
  Widget build(BuildContext context) {
    final miradorProvider = Provider.of<PanelMiradorProvider>(context);

    if (miradorProvider.addressController.text.isEmpty) {
      miradorProvider.addressController.text = miradorProvider.mirador.address;
    }
    if (miradorProvider.phoneController.text.isEmpty) {
      miradorProvider.phoneController.text = miradorProvider.mirador.phone;
    }
    if (miradorProvider.emailController.text.isEmpty) {
      miradorProvider.emailController.text = miradorProvider.mirador.email;
    }
    if (miradorProvider.instagramController.text.isEmpty) {
      miradorProvider.instagramController.text = miradorProvider.mirador.instagram;
    }
    if (miradorProvider.facebookController.text.isEmpty) {
      miradorProvider.facebookController.text = miradorProvider.mirador.facebook;
    }

    return Card(
      elevation: 3,
      color: Colors.grey[300],
      child: SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            const Padding(
            padding: EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextContacto(label: 'Dirección:', id: 1),
                  TextContacto(label: 'Celular:', id: 2),
                  TextContacto(label: 'Correo electrónico:', id: 3),
                  TextContacto(label: 'Instagram:', id: 4),
                  TextContacto(label: 'Facebook:', id: 5),
                ]
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: EditarWidget(
              id: 1,
              onEdit: () {  
                miradorProvider.cambiarMarcaContactoEdit();
              },
              onCheck: () {
                miradorProvider.agregarValor(miradorProvider.addressController, 'address');
                miradorProvider.agregarValor(miradorProvider.phoneController, 'phone');
                miradorProvider.agregarValor(miradorProvider.emailController, 'email');
                miradorProvider.agregarValor(miradorProvider.instagramController, 'instagram');
                miradorProvider.agregarValor(miradorProvider.facebookController, 'facebook');
                miradorProvider.cambiarMarcaContacto();
              },
            )
          )
          ],
        ),
      )
    );
  }
}
