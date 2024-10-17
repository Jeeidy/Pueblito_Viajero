import 'package:flutter/material.dart';
import 'package:pueblito_viajero/vistas/android/home/fragmentos/miradores.dart';

class PantallaInformacion extends StatelessWidget {
  const PantallaInformacion({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.only(top: 30),
          child: MiradoresFragmento(tipo: 'informacion',),
        )
      ),
    );
  }
}
