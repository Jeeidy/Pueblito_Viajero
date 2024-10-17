import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pueblito_viajero/utils/custom/custom_colors.dart';

class IconoTextSplash extends StatelessWidget {
  const IconoTextSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: GoogleFonts.inter(
          fontSize: kIsWeb ? 28 : 33,
          color: AppColors.negro87,
          letterSpacing: 2,
          height: 1.03,
        ),
        children: const [
          TextSpan(
            text: 'Pueblito ',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(
            text: 'viajero',
            style: TextStyle(
              color: AppColors.baseColorAI,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}