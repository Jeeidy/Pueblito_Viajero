import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/fragmentos/secciones/formulario_perfil.dart';
import '../../../../provider/screen_iniciar_sesion_provider.dart';
import '../../../../provider/panel_perfil_provider.dart';
import '../../../../utils/custom/custom_colors.dart';
import '../../../android/home/fragmentos/perfil.dart';

class PanelPerfil extends StatelessWidget {
  const PanelPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    final sesionProvider = Provider.of<IniciarSesionProvider>(context);
    final perfilProvider = Provider.of<PerfilProvider>(context);
    var image = sesionProvider.usuario.image;


    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Card(
            elevation: 3,
            color: Colors.grey[300],
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Center(
                    child: image == null
                    ? const Icon(Icons.person_2_outlined, color: AppColors.azulClaro, size: 120)
                    : Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.azulClaro,
                          width: 4.0,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          sesionProvider.usuario.image,
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error);
                          },
                        )
                      ),
                    ),
                  )
                ),
              Expanded(
                  flex: 10,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      sesionProvider.usuario.name.isEmpty
                      ? 'NOMBRE DE ADMINISTRADOR'
                      : sesionProvider.usuario.name.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  )
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 10,
          child: Row(
            children: [
              const Expanded(
                child: SeleccionOpcionesPerfil(),
              ),
              if (perfilProvider.selectedOption >= 1 && perfilProvider.selectedOption <= 5)
                const Expanded(
                  child: FormularioPerfil(),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
