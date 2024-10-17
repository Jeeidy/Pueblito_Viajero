import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/provider/screen_iniciar_sesion_provider.dart';
import '../../../../provider/panel_perfil_provider.dart';
import '../../../web/panel_screen/fragmentos/secciones/formulario_perfil.dart';

class PerfilFragmento extends StatelessWidget {
  const PerfilFragmento({super.key});

  @override
  Widget build(BuildContext context) {
    final sesionProvider = Provider.of<IniciarSesionProvider>(context);
    final perfilProvider = Provider.of<PerfilProvider>(context);
    final usuario = sesionProvider.usuario;

    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'PERFIL',
                style: GoogleFonts.inter(
                  fontSize: 33,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              usuario.image == '' || usuario.image == null
              ? const Icon(Icons.person_2_outlined, size: 100)
              : Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.green, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.35),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(usuario.image),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                usuario.name == '' || usuario.name.isEmpty
                ? 'Nombre del usuario'
                : usuario.name.split(' ').map((word) => word[0].toUpperCase() + word.substring(1)).join(' '),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 40),
            child: perfilProvider.selectedOption == 0
            ? const SeleccionOpcionesPerfil()
            : const FormularioPerfil()
          )
        ),
      ],
    );
  }
}


class SeleccionOpcionesPerfil extends StatelessWidget {
  const SeleccionOpcionesPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    final perfilProvider = Provider.of<PerfilProvider>(context);
    final sesionProvider = Provider.of<IniciarSesionProvider>(context);

    return Card(
        elevation: 3,
        color: Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                      title: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person),
                          SizedBox(width: 8.0),
                          Text('Datos personales'),
                        ],
                      ),
                      onTap: () {
                        perfilProvider.updateSelectedOption(1);
                      }
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                      title: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.lock),
                          SizedBox(width: 8.0),
                          Text('Contraseña y seguridad'),
                        ],
                      ),
                      onTap: () {
                        perfilProvider.updateSelectedOption(2);
                      }
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                      title: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.policy_outlined),
                          SizedBox(width: 8.0),
                          Text('Política de privacidad'),
                        ],
                      ),
                      onTap: () {
                        perfilProvider.updateSelectedOption(3);
                      }
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                      title: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.theater_comedy_outlined),
                          SizedBox(width: 8.0),
                          Text('Normas comunitarias'),
                        ],
                      ),
                      onTap: () {
                        perfilProvider.updateSelectedOption(4);
                      }
                  ),
                ),
              ),
              kIsWeb ? const SizedBox() : Expanded(
                child: Center(
                  child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                      title: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout),
                          SizedBox(width: 8.0),
                          Text('Cerrar sesión'),
                        ],
                      ),
                      onTap: () {
                        sesionProvider.logout(context);
                      }
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}

