import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/provider/screen_registro_provider.dart';
import 'package:pueblito_viajero/vistas/android/crear_cuenta/widgets/textfield_personalizable.dart';
import 'package:pueblito_viajero/vistas/widgets/boton_personalizable.dart';
import '../../../utils/custom/custom_colors.dart';
import '../../widgets/boton_sesion_redes.dart';

class PantallaCrearCuenta_1 extends StatelessWidget {
  const PantallaCrearCuenta_1({super.key});

  @override
  Widget build(BuildContext context) {
    final registroProvider = Provider.of<RegistroProvider>(context);

    void unfocusTextField() {
      registroProvider.emailFocusNode.unfocus();
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.blanco,
        body: GestureDetector(
          onTap: unfocusTextField,
          child: Center(
            child: Card(
              elevation: 3,
              color: AppColors.gris,
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
                          const Icon(
                            Icons.account_circle,
                            color: AppColors.verdeDivertido,
                            size: 150
                          ),
                          const SizedBox(height: 20),
                          TextFieldPersonalizable(
                            labelText: 'Correo electrónico',
                            hintText: 'Correo',
                            icon: Icons.mail,
                            controller: registroProvider.emailController,
                            keyboard: 'email',
                            focusNode: registroProvider.emailFocusNode,
                            type: '1',
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      BotonComun(
                        color: AppColors.verdeDivertido,
                        text: 'SIGUIENTE',
                        onPressed: (){
                          if (registroProvider.isValidEmail(registroProvider.emailController.text)) {
                            registroProvider.agregarValor(registroProvider.emailController, 'email');
                            registroProvider.siguiente(context);
                          } else {
                            registroProvider.showErrorDialog(
                              context,
                              'El correo electrónico no es válido.', 'email'
                            );
                          }
                        }
                      ),
                      const Divider(height: 40),
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
