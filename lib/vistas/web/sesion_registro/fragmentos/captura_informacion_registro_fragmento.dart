import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/provider/screen_registro_provider.dart';
import 'package:pueblito_viajero/vistas/android/crear_cuenta/widgets/textfield_personalizable.dart';

class CapturaInformacionRegistroFragmento extends StatelessWidget {
  const CapturaInformacionRegistroFragmento({super.key});

  @override
  Widget build(BuildContext context) {
    final registroProvider = Provider.of<RegistroProvider>(context);

    return Column(
      children: [
        TextFieldPersonalizable(
          labelText: 'Nombre:',
          hintText: 'Nombre',
          icon: Icons.person_2_outlined,
          controller: registroProvider.nameController,
          keyboard: 'name',
          focusNode: registroProvider.nameFocusNode,
          type: '1',
        ),
        const SizedBox(height: 20),
        TextFieldPersonalizable(
          labelText: 'Correo:',
          hintText: 'Correo electrónico',
          icon: Icons.mail_outline_rounded,
          controller: registroProvider.emailController,
          keyboard: 'email',
          focusNode: registroProvider.emailFocusNode,
          type: '1',
        ),
        const SizedBox(height: 20),
        TextFieldPersonalizable(
          labelText: 'Contraseña:',
          hintText: 'Contraseña',
          icon: Icons.key_outlined,
          controller: registroProvider.passwordController,
          keyboard: 'password',
          focusNode: registroProvider.passwordFocusNode,
          type: '1',
        ),
      ],
    );
  }
}