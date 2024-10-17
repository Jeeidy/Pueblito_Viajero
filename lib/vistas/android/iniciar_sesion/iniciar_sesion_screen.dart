import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/vistas/android/iniciar_sesion/recuperar_contrasenia.dart';

import '../../../provider/screen_iniciar_sesion_provider.dart';
import '../../../provider/screen_registro_provider.dart';
import '../../../utils/custom/custom_colors.dart';
import '../../widgets/boton_personalizable.dart';
import '../../widgets/boton_sesion_redes.dart';
import '../crear_cuenta/widgets/textfield_personalizable.dart';

class IniciarSesionPage extends StatelessWidget {
  const IniciarSesionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final iniciarSesionProvider = Provider.of<IniciarSesionProvider>(context);
    final registroProvider = Provider.of<RegistroProvider>(context);

    void unfocusTextField() {
      iniciarSesionProvider.emailFocusNode.unfocus();
    }

    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: GestureDetector(
            onTap: unfocusTextField,
            child: Center(
              child: Card(
                elevation: 3,
                color: Colors.grey[300],
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),
                        Column(
                          children: <Widget>[
                            const Icon(Icons.account_circle, color: AppColors.verdeDivertido, size: 150),
                            const SizedBox(height: 20),
                            TextFieldPersonalizable(
                              labelText: 'Correo electrónico',
                              hintText: 'Correo',
                              icon: Icons.mail,
                              controller: iniciarSesionProvider.emailController,
                              keyboard: 'email',
                              focusNode: iniciarSesionProvider.emailFocusNode,
                              type: '1',
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        BotonComun(
                          color: AppColors.verdeDivertido,
                          text: 'SIGUIENTE',
                          onPressed: (){
                            if (registroProvider.isValidEmail(iniciarSesionProvider.emailController.text)) {
                              iniciarSesionProvider.agregarValor(iniciarSesionProvider.emailController, 'email');
                              iniciarSesionProvider.siguiente(context);
                            } else {
                              registroProvider.showErrorDialog(context, 'El correo electrónico no es válido.', 'email');
                            }
                          }
                        ),
                        TextButton(
                          onPressed: () {
                            iniciarSesionProvider.cambiarMarcaForgetPassword();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const RecuperarContraseniaPage()),
                            );
                          },
                          child: const Text(
                            '¿Olvidaste tu contraseña?',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16
                            ),
                          ),
                        ),
                        const Divider(height: 30),
                        const Text(
                          'Usar otra cuenta:',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        const SizedBox(height: 5),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            BotonRedes(
                              text: 'Iniciar sesión con Google',
                              icon: Icons.g_translate_outlined,
                              onPressed: (){},
                              type: 'google',
                            ),
                            BotonRedes(
                              text: 'Iniciar sesión con Facebook',
                              icon: Icons.facebook_outlined,
                              onPressed: (){},
                              type: 'facebook',
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
  }
}

