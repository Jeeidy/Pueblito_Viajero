import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pueblito_viajero/vistas/android/home/widgets/texto_movil_contacto.dart';
import '../../../../../modelos/mirador_modelo.dart';
import '../../../../../utils/custom/custom_colors.dart';

class MiradorContacto extends StatelessWidget {
  final MiradorModel mirador;

  const MiradorContacto({required this.mirador, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: AppColors.verdeDivertido,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Center(
                child: Text(
                  'Información de contacto',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 2.3,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextoMovilContacto(
            dato: 'Dirección',
            texto: mirador.address,
            icono: const Icon(
              Icons.location_on_outlined,
              color: AppColors.verdeDivertido,
              size: 40,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Divider(
              color: Colors.grey.withOpacity(0.4),
              thickness: 0.8,
              height: 3,
            ),
          ),
          TextoMovilContacto(
            dato: 'Celular',
            texto: mirador.phone,
            icono: const Icon(
              Icons.phone,
              color: AppColors.verdeDivertido,
              size: 40,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Divider(
              color: Colors.grey.withOpacity(0.4),
              thickness: 0.8,
              height: 3,
            ),
          ),
          TextoMovilContacto(
            dato: 'Correo electrónico',
            texto: mirador.email,
            icono: const Icon(
              Icons.mail_outline_rounded,
              color: AppColors.verdeDivertido,
              size: 40,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Divider(
              color: Colors.grey.withOpacity(0.4),
              thickness: 0.8,
              height: 3,
            ),
          ),
          TextoMovilContacto(
            dato: 'Instagram',
            texto: mirador.instagram,
            icono: const Icon(
              Icons.camera_alt_outlined,
              color: AppColors.verdeDivertido,
              size: 40,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Divider(
              color: Colors.grey.withOpacity(0.4),
              thickness: 0.8,
              height: 3,
            ),
          ),
          TextoMovilContacto(
            dato: 'Facebook',
            texto: mirador.facebook,
            icono: const Icon(
              Icons.facebook_outlined,
              color: AppColors.verdeDivertido,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}
