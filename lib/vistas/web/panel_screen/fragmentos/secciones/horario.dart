import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/widgets/textfield_mirador.dart';

import '../../../../../provider/screen_iniciar_sesion_provider.dart';
import '../../../../../provider/panel_mirador_provider.dart';

class HorarioSeccion extends StatelessWidget {
  const HorarioSeccion({super.key});

  @override
  Widget build(BuildContext context) {
    final miradorProvider = Provider.of<PanelMiradorProvider>(context);
    final sesionProvider = Provider.of<IniciarSesionProvider>(context);

    final horario_1 = miradorProvider.mirador.hora.isNotEmpty ? miradorProvider.mirador.hora[0] : '';
    final horario_2 = miradorProvider.mirador.hora.length > 1 ? miradorProvider.mirador.hora[1] : '';

    final horario_3 = sesionProvider.mirador.hora.isNotEmpty ? sesionProvider.mirador.hora[0] : '';
    final horario_4 = sesionProvider.mirador.hora.length > 1 ? sesionProvider.mirador.hora[1] : '';

    return Card(
      elevation: 3,
      color: Colors.grey[300],
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'LUNES - VIERNES',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                miradorProvider.horarioEdit
                ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFieldNombreMirador(
                        hintText: '00:00',
                        controller: miradorProvider.horario1Controller,
                        focusNode: miradorProvider.horario1FocusNode,
                        keyboardType: TextInputType.datetime,
                      ),
                      const SizedBox(width: 10),
                      DropdownButton<String>(
                        value: miradorProvider.horario1AmPm,
                        onChanged: (String? newValue) {
                          miradorProvider.setHorario1AmPm(newValue!);
                        },
                        items: <String>['AM', 'PM']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('-'),
                      ),
                      TextFieldNombreMirador(
                        hintText: '00:00',
                        controller: miradorProvider.horario2Controller,
                        focusNode: miradorProvider.horario2FocusNode,
                        keyboardType: TextInputType.datetime,
                      ),
                      const SizedBox(width: 10),
                      DropdownButton<String>(
                        value: miradorProvider.horario2AmPm,
                        onChanged: (String? newValue) {
                          miradorProvider.setHorario2AmPm(newValue!);
                        },
                        items: <String>['AM', 'PM']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                )
                : Text(
                  horario_1 == '' && horario_3 == ''
                  ? '0:00 AM - 0:00 PM'
                  : horario_1 == '' ? horario_3!.toUpperCase()
                  : horario_3 == '' ? horario_1!.toUpperCase()
                  : miradorProvider.horarios[0]!.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'SABADOS - DOMINGOS - FESTIVOS',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                miradorProvider.horarioEdit
                ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFieldNombreMirador(
                        hintText: '00:00',
                        controller: miradorProvider.horario3Controller,
                        focusNode: miradorProvider.horario3FocusNode,
                        keyboardType: TextInputType.datetime,
                      ),
                      const SizedBox(width: 10),
                      DropdownButton<String>(
                        value: miradorProvider.horario3AmPm,
                        onChanged: (String? newValue) {
                          miradorProvider.setHorario3AmPm(newValue!);
                        },
                        items: <String>['AM', 'PM']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('-'),
                      ),
                      TextFieldNombreMirador(
                        hintText: '00:00',
                        controller: miradorProvider.horario4Controller,
                        focusNode: miradorProvider.horario4FocusNode,
                        keyboardType: TextInputType.datetime,
                      ),
                      const SizedBox(width: 10),
                      DropdownButton<String>(
                        value: miradorProvider.horario4AmPm,
                        onChanged: (String? newValue) {
                          miradorProvider.setHorario4AmPm(newValue!);
                        },
                        items: <String>['AM', 'PM']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                )
                : Text(
                  horario_2 == '' && horario_4 == ''
                  ? '0:00 AM - 0:00 PM'
                  : horario_2 == '' ? horario_4!.toUpperCase()
                  : horario_4 == '' ? horario_2!.toUpperCase()
                  : miradorProvider.horarios[1]!.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black,
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
