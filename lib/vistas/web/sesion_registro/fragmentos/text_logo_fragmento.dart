import 'package:flutter/material.dart';

import '../../../widgets/icono_text_splash.dart';

class TextLogoFragmento extends StatelessWidget {
  const TextLogoFragmento({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/logo.png', height: 250),
        const SizedBox(height: 10),
        const IconoTextSplash()
      ],
    );
  }
}
