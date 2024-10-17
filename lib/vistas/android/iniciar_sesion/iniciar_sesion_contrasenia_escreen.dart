import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/vistas/android/iniciar_sesion/widgets/textfield_contrasenia.dart';
import '../../../provider/screen_iniciar_sesion_provider.dart';
import '../../../utils/custom/custom_colors.dart';
import '../../widgets/boton_personalizable.dart';

class PantallaSesionContrasenia extends StatelessWidget {
  const PantallaSesionContrasenia({super.key});

  @override
  Widget build(BuildContext context) {
    final sesionProvider = Provider.of<IniciarSesionProvider>(context);

    void unfocusTextField() {
      sesionProvider.passwordFocusNode.unfocus();
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
                          Text(
                            sesionProvider.usuario.email,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 35),
                          CustomPasswordField(
                            controller: sesionProvider.passwordController,
                            focusNode: sesionProvider.passwordFocusNode,
                            onToggleVisibility: () {
                              sesionProvider.togglePasswordVisibility();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      sesionProvider.isLoading
                      ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.verdeDivertido
                          )
                        ),
                      )
                      : BotonComun(
                        color: AppColors.verdeDivertido,
                        text: 'INICIAR SESIÓN',
                        onPressed: (){
                          sesionProvider.agregarValor(
                            sesionProvider.passwordController,
                            'password'
                          );
                          sesionProvider.login(context);
                        },
                      ),
                      TextButton(
                        onPressed: (){},
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