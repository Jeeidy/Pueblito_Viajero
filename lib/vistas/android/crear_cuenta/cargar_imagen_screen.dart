import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/vistas/widgets/boton_personalizable_icono.dart';

import '../../../provider/screen_registro_provider.dart';
import '../../../utils/custom/custom_colors.dart';

class UploadImagePage extends StatelessWidget {
  const UploadImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final registroProvider = Provider.of<RegistroProvider>(context);
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Card(
            elevation: 3,
            color: Colors.grey[300],
            margin: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              height: height * 0.915,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      registroProvider.usuario.image == null
                      ? const Icon(Icons.account_circle, color: AppColors.verdeDivertido, size: 250)
                      : Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(125),
                        ),
                        child: Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.verdeDivertido,
                              width: 4.0,
                            ),
                          ),
                          child: ClipOval(
                            child: Image.file(
                              registroProvider.usuario.image as File,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BotonConIconoVertical(
                            text: 'Tomar foto',
                            iconColor: AppColors.verdeDivertido,
                            iconSize: 50,
                            fontSize: 18,
                            icon: Icons.camera_enhance,
                            onPressed: () => registroProvider.pickImageFromCamera(),
                          ),
                          BotonConIconoVertical(
                            text: 'Buscar foto',
                            iconColor: AppColors.verdeDivertido,
                            iconSize: 50,
                            fontSize: 18,
                            icon: Icons.image_search_outlined,
                            onPressed: () => registroProvider.pickImageFromGallery(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      registroProvider.isLoading
                        ? const Center(child: CircularProgressIndicator(color: AppColors.verdeDivertido))
                        : BotonConIconoIzquierda(
                        text: 'SUBIR',
                        icon: Icons.file_upload_outlined,
                        onPressed: () {
                          registroProvider.registrarUsuario(context);
                        }
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
