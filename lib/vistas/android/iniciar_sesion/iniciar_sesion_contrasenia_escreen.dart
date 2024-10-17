import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/vistas/android/iniciar_sesion/widgets/textfield_contrasenia.dart';

import '../../../provider/screen_iniciar_sesion_provider.dart';
import '../../../utils/custom/custom_colors.dart';
import '../../widgets/boton_personalizable.dart';

class IniciarContraseniaPage extends StatelessWidget {
  const IniciarContraseniaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final inicioSesionProvider = Provider.of<IniciarSesionProvider>(context);

    void unfocusTextField() {
      inicioSesionProvider.passwordFocusNode.unfocus();
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
                            Text(
                              inicioSesionProvider.usuario.email,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const SizedBox(height: 15),
                            CustomPasswordField(
                              controller: inicioSesionProvider.passwordController,
                              focusNode: inicioSesionProvider.passwordFocusNode,
                              onToggleVisibility: () {
                                inicioSesionProvider.togglePasswordVisibility();
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        inicioSesionProvider.isLoading
                        ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Center(child: CircularProgressIndicator(color: AppColors.verdeDivertido)),
                        )
                        : BotonComun(
                            color: AppColors.verdeDivertido,
                            text: 'INICIAR SESIÓN',
                            onPressed: (){
                              inicioSesionProvider.agregarValor(inicioSesionProvider.passwordController, 'password');
                              inicioSesionProvider.login(context);
                            },
                          ),
                        TextButton(
                          onPressed: () {  },
                          child: const Text(
                            '¿Olvidaste tu contraseña?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
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