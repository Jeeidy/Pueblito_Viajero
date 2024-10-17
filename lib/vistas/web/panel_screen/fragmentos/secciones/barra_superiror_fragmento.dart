import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/screen_iniciar_sesion_provider.dart';
import '../../../../../provider/panel_inicio_provider.dart';
import '../../../../../utils/custom/custom_colors.dart';

class CardBarraSuperior extends StatelessWidget {
  const CardBarraSuperior({super.key});

  @override
  Widget build(BuildContext context) {
    final panelProvider = Provider.of<PanelProvider>(context);
    final sesionProvider = Provider.of<IniciarSesionProvider>(context);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color:AppColors.azulClaro,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Center(
                  child: Image.asset('assets/logo.png', height: 65),
                )
            ),
            Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Center(
                    child: Text(
                      'PANEL ADMINISTRATIVO',
                      style: GoogleFonts.inter(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        letterSpacing: 1,
                        height: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
            ),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.home_outlined, size: 37, color: AppColors.amarilloSupernova),
                        onPressed: () {
                          panelProvider.actualizarPantalla(0);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.person_2_outlined, size: 37, color: AppColors.amarilloSupernova),
                        onPressed: () {
                          panelProvider.actualizarPantalla(4);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.power_settings_new_outlined, size: 37, color: AppColors.amarilloSupernova),
                        onPressed: () {
                          sesionProvider.logout(context);
                        },
                      ),
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
