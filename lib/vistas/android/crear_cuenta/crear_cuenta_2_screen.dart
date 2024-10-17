import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/vistas/android/crear_cuenta/widgets/textfield_personalizable.dart';

import '../../../provider/screen_registro_provider.dart';
import '../../../utils/custom/custom_colors.dart';
import '../../widgets/boton_personalizable.dart';

class CrearCuenta2Page extends StatelessWidget {
  const CrearCuenta2Page({super.key});

  @override
  Widget build(BuildContext context) {
    final registroProvider = Provider.of<RegistroProvider>(context);

    void unfocusTextField() {
      registroProvider.passwordFocusNode.unfocus();
      registroProvider.nameFocusNode.unfocus();
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
                            TextFieldPersonalizable(
                              labelText: 'Contraseña:',
                              hintText: 'Contraseña',
                              icon: Icons.key_outlined,
                              controller: registroProvider.passwordController,
                              keyboard: 'email',
                              focusNode: registroProvider.passwordFocusNode,
                              type: '1',
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        BotonComun(
                            color: AppColors.verdeDivertido,
                            text: 'SIGUIENTE',
                            onPressed: (){
                              if (!registroProvider.isValidName(registroProvider.nameController.text)) {
                                registroProvider.showErrorDialog(context, 'El nombre esta vacio.', 'empty');
                              } else if (!registroProvider.isValidPassword(registroProvider.passwordController.text)) {
                                registroProvider.showErrorDialog(context, 'La contraseña debe tener al menos 8 caracteres.', 'caracter');
                              } else {
                                registroProvider.agregarValor(registroProvider.nameController, 'name');
                                registroProvider.agregarValor(registroProvider.passwordController, 'password');
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
