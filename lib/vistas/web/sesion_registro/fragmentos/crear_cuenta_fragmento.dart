import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/provider/screen_iniciar_sesion_provider.dart';
import 'package:pueblito_viajero/provider/screen_registro_provider.dart';
import 'package:pueblito_viajero/utils/custom/custom_colors.dart';
import 'package:pueblito_viajero/vistas/widgets/boton_personalizable.dart';
import '../../../android/crear_cuenta/widgets/textfield_personalizable.dart';
import '../../../android/iniciar_sesion/widgets/textfield_contrasenia.dart';
import '../../../widgets/boton_personalizable_icono.dart';

class CrearCuentaFragmento extends StatelessWidget {
  const CrearCuentaFragmento({super.key});

  @override
  Widget build(BuildContext context) {
    final registroProvider = Provider.of<RegistroProvider>(context);
    final sesionProvider = Provider.of<IniciarSesionProvider>(context);
    var height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.gris,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(50, 30, 50, 25),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'CREA UNA CUENTA',
                    textAlign: TextAlign.center,
                    maxLines: 5,
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 3,
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.03),
                registroProvider.capturaInfo
                ? const CargarImagenFragmento()
                : const CapturaInformacionRegistroFragmento(),
                const SizedBox(height: 20),
                registroProvider.isLoading
                ? const Center(child: CircularProgressIndicator(color: AppColors.azulClaro))
                : Column(
                  children: [
                    BotonComun(
                      color: AppColors.azulClaro,
                      text: registroProvider.capturaInfo ? 'CREAR CUENTA' : 'SIGUIENTE',
                      onPressed: registroProvider.capturaInfo
                      ? () {
                        registroProvider.registrarUsuario(context);
                        sesionProvider.togglePasswordVisibility();
                        registroProvider.siguienteWebFalse();
                      }
                      : () {
                        registroProvider.agregarValor(registroProvider.nameController, 'name');
                        registroProvider.agregarValor(registroProvider.emailController, 'email');
                        registroProvider.agregarValor(registroProvider.passwordController, 'password');
                        registroProvider.siguienteWeb();
                      },
                    ),
                    registroProvider.capturaInfo
                    ? const SizedBox(height: 0)
                    : BotonComunIcono(
                      color: Colors.grey[500]!,
                      text: 'INICIAR CON GOOGLE',
                      onPressed: (){
                        sesionProvider.loginWithGoogle(context);
                      },
                      icono: const Icon(Icons.g_translate_outlined, color: AppColors.azulClaro, size: 25),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      registroProvider.siguienteWebFalse();
                      sesionProvider.toggleAuthProcess();
                      registroProvider.limpiarImagen();
                    },
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: '¿Ya tienes una cuenta?',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: ' Inicia sesión',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


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

class CapturaInformacionRegistroFragmento extends StatelessWidget {
  const CapturaInformacionRegistroFragmento({super.key});

  @override
  Widget build(BuildContext context) {
    final registroProvider = Provider.of<RegistroProvider>(context);
    final sesionProvider = Provider.of<IniciarSesionProvider>(context);

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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contraseña:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            CustomPasswordField(
              controller: registroProvider.passwordController,
              focusNode: registroProvider.passwordFocusNode,
              onToggleVisibility: () {
                sesionProvider.togglePasswordVisibility();
              },
            ),
          ],
        ),

      ],
    );
  }
}
