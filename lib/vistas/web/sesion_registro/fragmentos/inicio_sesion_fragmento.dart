import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/provider/screen_iniciar_sesion_provider.dart';
import 'package:pueblito_viajero/utils/custom/custom_colors.dart';
import 'package:pueblito_viajero/vistas/android/crear_cuenta/widgets/textfield_personalizable.dart';
import 'package:pueblito_viajero/vistas/android/iniciar_sesion/widgets/textfield_contrasenia.dart';
import 'package:pueblito_viajero/vistas/widgets/boton_personalizable.dart';

import '../../../../provider/panel_perfil_provider.dart';
import '../../../../provider/screen_registro_provider.dart';

class InicioSesionFragmento extends StatelessWidget {
  const InicioSesionFragmento({super.key});

  @override
  Widget build(BuildContext context) {
    final sesionProvider = Provider.of<IniciarSesionProvider>(context);
    var height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Center(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(50, 20, 50, 25),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child:
                  Text(
                    sesionProvider.isForgetPassword
                    ? 'RESTABLECE TU CONTRASEÑA'
                    : 'INICIA SESIÓN EN EL PANEL ADMINISTRATIVO',
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
                SizedBox(height: height * 0.05),
                sesionProvider.isForgetPassword
                ? const ContraseniaOlvidadaFragmento()
                : const FormularioInicioSesion(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FormularioInicioSesion extends StatelessWidget {
  const FormularioInicioSesion({super.key});

  @override
  Widget build(BuildContext context) {
    final sesionProvider = Provider.of<IniciarSesionProvider>(context);
    final registroProvider = Provider.of<RegistroProvider>(context);

    return Column(
      children: [
        TextFieldPersonalizable(
          labelText: 'Correo:',
          hintText: 'Correo electrónico',
          icon: Icons.mail_outline_rounded,
          controller: sesionProvider.emailController,
          keyboard: 'email',
          focusNode: sesionProvider.emailFocusNode,
          type: '1',
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contraseña:',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            CustomPasswordField(
              controller: sesionProvider.passwordController,
              focusNode: sesionProvider.passwordFocusNode,
              onToggleVisibility: () {
                sesionProvider.togglePasswordVisibility();
              },
            ),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed: () {
                  sesionProvider.cambiarMarcaForgetPassword();
                },
                child: const Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            sesionProvider.isLoading
            ? const Center(child: CircularProgressIndicator(color: AppColors.azulClaro))
            : BotonComun(
                color: AppColors.azulClaro,
                text: 'INICIAR SESIÓN',
                onPressed: () {
                  if (registroProvider.isValidEmail(sesionProvider.emailController.text)) {
                    if(registroProvider.isValidPassword(sesionProvider.passwordController.text)){
                      sesionProvider.agregarValor(sesionProvider.emailController, 'email');
                      sesionProvider.agregarValor(sesionProvider.passwordController, 'password');
                      sesionProvider.login(context);
                    } else {
                      registroProvider.showErrorDialog(context, 'La contraseña debe tener al menos 8 caracteres.', 'caracter');
                    }
                  } else {
                    registroProvider.showErrorDialog(context, 'El correo electrónico no es válido.', 'email');
                  }
                }
            ),
            const SizedBox(height: 15),
            Container(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  sesionProvider.toggleAuthProcess();
                },
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: '¿No tienes una cuenta?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: ' Regístrate',
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
      ],
    );
  }
}



class ContraseniaOlvidadaFragmento extends StatelessWidget {
  const ContraseniaOlvidadaFragmento({super.key});

  @override
  Widget build(BuildContext context) {
    final sesionProvider = Provider.of<IniciarSesionProvider>(context);
    final perfilProvider = Provider.of<PerfilProvider>(context);
    var height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextFieldPersonalizable(
            labelText: 'Correo:',
            hintText: 'Correo electrónico',
            icon: Icons.mail_outline_rounded,
            controller: sesionProvider.emailController,
            keyboard: 'email',
            focusNode: sesionProvider.emailFocusNode,
            type: '1',
          ),
          SizedBox(height: height * 0.20),
          sesionProvider.isLoading_2
          ? const CircularProgressIndicator(color: AppColors.azulClaro)
          : BotonComun(
            color: AppColors.azulClaro,
            text: 'ENVIAR LINK DE RESTABLECIMIENTO',
            onPressed: () {
              sesionProvider.sendPasswordResetEmail(context);
            }
          ),
          BotonComun(
            color: kIsWeb ? AppColors.azulClaro : AppColors.verdeDivertido,
            text: 'CANCELAR',
            onPressed: (){
              perfilProvider.updateSelectedOption(0);
              sesionProvider.cambiarMarcaForgetPasswordFalse();
            }
          )
        ],
      ),
    );
  }
}
