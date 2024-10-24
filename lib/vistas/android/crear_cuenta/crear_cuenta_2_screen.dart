import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/vistas/android/crear_cuenta/widgets/textfield_personalizable.dart';
import '../../../provider/screen_iniciar_sesion_provider.dart';
import '../../../provider/screen_registro_provider.dart';
import '../../../utils/custom/custom_colors.dart';
import '../../widgets/boton_personalizable.dart';
import '../iniciar_sesion/widgets/textfield_contrasenia.dart';

class PantallaCrearCuenta_2 extends StatelessWidget {
  const PantallaCrearCuenta_2({super.key});

  @override
  Widget build(BuildContext context) {
    final registroProvider = Provider.of<RegistroProvider>(context);
    final sesionProvider = Provider.of<IniciarSesionProvider>(context);

    void unfocusTextField() {
      registroProvider.passwordFocusNode.unfocus();
      registroProvider.nameFocusNode.unfocus();
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
                            registroProvider.usuario.email,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFieldPersonalizable(
                            labelText: 'Nombre:',
                            hintText: 'Nombre',
                            icon: Icons.person_2_outlined,
                            controller: registroProvider.nameController,
                            keyboard: 'name',
                            focusNode: registroProvider.nameFocusNode,
                            type: '1',
                          ),
                          const SizedBox(height: 15),
                          CustomPasswordField(
                            controller: registroProvider.passwordController,
                            focusNode: registroProvider.passwordFocusNode,
                            onToggleVisibility: () {
                              sesionProvider.togglePasswordVisibility();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      BotonComun(
                        color: AppColors.verdeDivertido,
                        text: 'SIGUIENTE',
                        onPressed: (){
                          if (!registroProvider.isValidName(registroProvider.nameController.text)) {
                            registroProvider.showErrorDialog(
                              context, 'El nombre esta vacio.', 'empty'
                            );
                          } else if (!registroProvider.isValidPassword(
                              registroProvider.passwordController.text)) {
                            registroProvider.showErrorDialog(
                              context, 'La contraseña debe tener al menos 8 caracteres.', 'caracter');
                          } else {
                            registroProvider.agregarValor(registroProvider.nameController, 'name');
                            registroProvider.agregarValor(registroProvider.passwordController, 'password');
                            registroProvider.isPasswordVisible = false;
                            registroProvider.siguiente2(context);
                          }
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
