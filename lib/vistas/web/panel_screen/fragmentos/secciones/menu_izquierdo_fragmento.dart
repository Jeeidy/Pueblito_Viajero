import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/panel_inicio_provider.dart';
import '../../../../../utils/custom/custom_colors.dart';

class CardMenuIzquierdo extends StatelessWidget {
  const CardMenuIzquierdo({super.key});

  @override
  Widget build(BuildContext context) {
    final panelProvider = Provider.of<PanelProvider>(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.azulClaro,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  panelProvider.actualizarPantalla(0);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: panelProvider.screen == 0 ? Colors.blue : null,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[300]!,
                        width: 0.7,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Inicio',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        letterSpacing: 1,
                        height: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  panelProvider.actualizarPantalla(1);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: panelProvider.screen == 1 ? Colors.blue : null,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[300]!,
                        width: 0.7,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Mirador',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        letterSpacing: 1,
                        height: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  panelProvider.actualizarPantalla(2);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: panelProvider.screen == 2 ? Colors.blue : null,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[300]!,
                        width: 0.7,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Eventos',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        letterSpacing: 1,
                        height: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  panelProvider.actualizarPantalla(3);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: panelProvider.screen == 3 ? Colors.blue : null,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[300]!,
                        width: 0.7,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Oferta Laboral',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        letterSpacing: 1,
                        height: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  panelProvider.actualizarPantalla(4);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: panelProvider.screen == 4 ? Colors.blue : null,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Perfil',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        letterSpacing: 1,
                        height: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
