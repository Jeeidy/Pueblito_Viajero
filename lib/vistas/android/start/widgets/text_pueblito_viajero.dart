import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/custom/custom_colors.dart';

class TextPueblitoViajero extends StatelessWidget {
  const TextPueblitoViajero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.verdeDivertido,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'PUEBLITO',
              style: GoogleFonts.inter(
                fontSize: 40,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 2,
                height: 1.03,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'VIAJERO',
              style: GoogleFonts.inter(
                fontSize: 40,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 2,
                height: 1.03,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
