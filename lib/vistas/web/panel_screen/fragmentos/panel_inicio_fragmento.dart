import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/provider/screen_iniciar_sesion_provider.dart';
import 'package:pueblito_viajero/provider/panel_mirador_provider.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/widgets/card_meses.dart';
import 'package:pueblito_viajero/vistas/widgets/grafica.dart';
import 'package:pueblito_viajero/vistas/widgets/grafica_pie.dart';

import '../../../../utils/custom/custom_colors.dart';

class PanelCentralFragmento extends StatelessWidget {
  const PanelCentralFragmento({super.key});

  @override
  Widget build(BuildContext context) {
    final miradorProvider = Provider.of<PanelMiradorProvider>(context);
    final sesionProvider = Provider.of<IniciarSesionProvider>(context);
    final name = miradorProvider.mirador.name;
    final name_2 = sesionProvider.mirador.name;
    final image = miradorProvider.imagenUrl;
    final image_2 = sesionProvider.mirador.image;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Center(
                          child: (image == null || image.isEmpty) && (image_2 == null || image_2.isEmpty)
                          ? const Icon(Icons.account_balance_rounded, color: AppColors.azulClaro, size: 120)
                          : Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.azulClaro,
                                width: 4.0,
                              ),
                            ),
                            child: ClipOval(
                              child: Image.network(
                                image == '' ? image_2 :
                                image_2 == '' ? image : null,
                                fit: BoxFit.cover
                              ),
                            ),
                          ),
                        )
                    ),
                    Expanded(
                        flex: 4,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            name == '' && name_2 == ''
                            ? 'NOMBRE DE MIRADOR'
                            : name == '' ? name_2.toUpperCase()
                            : name_2 == '' ? name.toUpperCase()
                            : '',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: screenWidth >= 730
            ? const Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: CardMeses(text: 'Enero')),
                      Expanded(child: CardMeses(text: 'Febrero')),
                      Expanded(child: CardMeses(text: 'Marzo')),
                      Expanded(child: CardMeses(text: 'Abril')),
                      Expanded(child: CardMeses(text: 'Mayo')),
                      Expanded(child: CardMeses(text: 'Junio')),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: CardMeses(text: 'Julio')),
                      Expanded(child: CardMeses(text: 'Agosto')),
                      Expanded(child: CardMeses(text: 'Septiembre')),
                      Expanded(child: CardMeses(text: 'Octubre')),
                      Expanded(child: CardMeses(text: 'Noviembre')),
                      Expanded(child: CardMeses(text: 'Diciembre')),
                    ],
                  ),
                ),
              ],
            )
            : const Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: CardMeses(text: 'Enero')),
                      Expanded(child: CardMeses(text: 'Febrero')),
                      Expanded(child: CardMeses(text: 'Marzo')),
                      Expanded(child: CardMeses(text: 'Abril')),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: CardMeses(text: 'Mayo')),
                      Expanded(child: CardMeses(text: 'Junio')),
                      Expanded(child: CardMeses(text: 'Julio')),
                      Expanded(child: CardMeses(text: 'Agosto')),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: CardMeses(text: 'Septiembre')),
                      Expanded(child: CardMeses(text: 'Octubre')),
                      Expanded(child: CardMeses(text: 'Noviembre')),
                      Expanded(child: CardMeses(text: 'Diciembre')),
                    ],
                  ),
                ),
              ],
            )
          ),
        ),
        Expanded(
          flex: 2,
          child: screenWidth >= 1000
          ? Row(
            children: [
              Expanded(
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(child: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 15),
                      child: Grafica(),
                    )),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(child: GraficaPie()),
                  ),
                ),
              ),
            ],
          )
          : Padding(
            padding: const EdgeInsets.all(3),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 250,
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(child: Grafica()),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 250,
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(child: GraficaPie()),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ),
      ],
    );
  }
}
