import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../modelos/mirador_modelo.dart';
import '../../../../../utils/custom/custom_colors.dart';

class MiradorServicios extends StatelessWidget {
  final MiradorModel mirador;
  const MiradorServicios({super.key, required this.mirador});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Card(
            color: AppColors.verdeDivertido,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Center(
                child: Text(
                  'Servicios',
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
        ),
        ...mirador.servicios.where((servicio) => servicio != null && servicio.isNotEmpty).map((servicio) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      color: AppColors.verdeDivertido,
                      size: 26,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      servicio!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Divider(
                    color: Colors.grey.withOpacity(0.4),
                    thickness: 0.8,
                    height: 3,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}