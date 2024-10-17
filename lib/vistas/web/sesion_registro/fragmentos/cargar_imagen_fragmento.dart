import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/screen_registro_provider.dart';
import '../../../../utils/custom/custom_colors.dart';
import '../../../widgets/boton_personalizable_icono.dart';

class CargarImagenFragmento extends StatelessWidget {
  const CargarImagenFragmento({super.key});

  @override
  Widget build(BuildContext context) {
    final registroProvider = Provider.of<RegistroProvider>(context);
    var height = MediaQuery.of(context).size.height;
    final image = registroProvider.usuario.image;

    return Column(
      children: [
        SizedBox(height: height * 0.04),
        image == null
        ? const Icon(Icons.account_circle, color: AppColors.azulClaro, size: 120)
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
            child: Image.memory(image as Uint8List, fit: BoxFit.cover)
          ),
        ),
        const SizedBox(height: 20),
        BotonConIconoVertical(
          text: 'Buscar foto',
          iconColor: AppColors.azulClaro,
          iconSize: 40,
          fontSize: 14,
          icon: Icons.image_search_outlined,
          onPressed: () => registroProvider.pickImageFromGallery(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
