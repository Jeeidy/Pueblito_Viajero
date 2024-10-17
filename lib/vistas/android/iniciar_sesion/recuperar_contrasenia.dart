import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/screen_iniciar_sesion_provider.dart';
import '../../../utils/custom/custom_colors.dart';
import '../../widgets/boton_personalizable.dart';
import '../crear_cuenta/widgets/textfield_personalizable.dart';

class RecuperarContraseniaPage extends StatelessWidget {
  const RecuperarContraseniaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sesionProvider = Provider.of<IniciarSesionProvider>(context);

    void unfocusTextField() {
      sesionProvider.emailFocusNode.unfocus();
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
                          const Padding(
                            padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                            child: Text(
                              'Ingresa tu correo electrónico y te enviaremos un link para recuperar tu contraseña',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextFieldPersonalizable(
                            labelText: 'Correo electrónico',
                            hintText: 'Correo',
                            icon: Icons.mail,
                            controller: sesionProvider.emailController,
                            keyboard: 'email',
                            focusNode: sesionProvider.emailFocusNode,
                            type: '1',
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      sesionProvider.isLoading_2
                      ? const Padding(
                        padding: EdgeInsets.all(15),
                        child: CircularProgressIndicator(color: AppColors.verdeDivertido),
                      )
                      : BotonComun(
                        color: AppColors.verdeDivertido,
                        text: 'ENVIAR LINK',
                        onPressed: () {
                          sesionProvider.sendPasswordResetEmail(context);
                        }
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
