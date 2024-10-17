import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/screen_iniciar_sesion_provider.dart';
import '../../../../utils/custom/custom_colors.dart';
class CustomPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onToggleVisibility;
  final FocusNode focusNode;

  const CustomPasswordField({
    super.key,
    required this.controller,
    required this.onToggleVisibility, required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final inicioSesionProvider = Provider.of<IniciarSesionProvider>(context);

    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      height: 60,
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        keyboardType: TextInputType.visiblePassword,
        obscureText: inicioSesionProvider.isPasswordVisible,
        style: const TextStyle(color: Colors.black87),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(top: 14),
          prefixIcon: Icon(Icons.key_outlined, color: kIsWeb ? Colors.black : Colors.grey[400]),
          suffixIcon: IconButton(
            color: kIsWeb ? Colors.black : AppColors.verdeDivertido,
            onPressed: onToggleVisibility,
            icon: inicioSesionProvider.isPasswordVisible
            ? const Icon(Icons.remove_red_eye_outlined)
            : const Icon(Icons.remove_red_eye),
          ),
          hintText: 'Contraseña',
          hintStyle: const TextStyle(color: Colors.black38),
        ),
      ),
    );
  }
}