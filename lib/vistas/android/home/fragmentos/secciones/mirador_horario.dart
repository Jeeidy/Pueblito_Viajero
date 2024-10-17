import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../modelos/mirador_modelo.dart';
import '../../../../../utils/custom/custom_colors.dart';

class MiradorHorario extends StatelessWidget {
  final MiradorModel mirador;
  const MiradorHorario({super.key, required this.mirador});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
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
                  'Horario',
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
        const Text(
          'LUNES - VIERNES',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Text(
          mirador.hora[0]!,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(height: 10),
        const Text(
          'SABADOS - DOMINGOS - FESTIVOS',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Text(
          mirador.hora[1]!,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
      ],
    );
  }
}
