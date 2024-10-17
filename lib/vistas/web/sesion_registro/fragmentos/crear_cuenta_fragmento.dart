import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/provider/screen_iniciar_sesion_provider.dart';
import 'package:pueblito_viajero/provider/screen_registro_provider.dart';
import 'package:pueblito_viajero/utils/custom/custom_colors.dart';
import 'package:pueblito_viajero/vistas/web/sesion_registro/fragmentos/captura_informacion_registro_fragmento.dart';
import 'package:pueblito_viajero/vistas/web/sesion_registro/fragmentos/cargar_imagen_fragmento.dart';
import 'package:pueblito_viajero/vistas/widgets/boton_personalizable.dart';

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
          color: Colors.grey[300],
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
            padding: const EdgeInsets.fromLTRB(50, 20, 50, 25),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'CREA UNA CUENTA ADMINISTRATIVA',
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
                : BotonComun(
                  color: AppColors.azulClaro,
                  text: registroProvider.capturaInfo ? 'CREAR CUENTA' : 'SIGUIENTE',
                  onPressed: registroProvider.capturaInfo
                  ? () {
                    registroProvider.registrarUsuario(context);
                    registroProvider.siguienteWebFalse();
                  }
                  : () {
                    registroProvider.agregarValor(registroProvider.nameController, 'name');
                    registroProvider.agregarValor(registroProvider.emailController, 'email');
                    registroProvider.agregarValor(registroProvider.passwordController, 'password');
                    registroProvider.siguienteWeb();
                  },
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