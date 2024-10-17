import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/vistas/android/home/fragmentos/secciones/barra_busqueda.dart';

import '../../../../provider/fragmento_miradores_provider.dart';
import '../widgets/card_miradores.dart';

class MiradoresFragmento extends StatefulWidget {
  final String tipo;
  const MiradoresFragmento({super.key, required this.tipo});

  @override
  _MiradoresFragmentoState createState() => _MiradoresFragmentoState();
}

class _MiradoresFragmentoState extends State<MiradoresFragmento> {
  @override
  void initState() {
    super.initState();
    Provider.of<MiradoresFragmentoProvider>(context, listen: false).cargarMiradores();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MiradoresFragmentoProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            const Expanded(
              flex: 1,
              child: BarraBusqueda(),
            ),
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: ListView.builder(
                  itemCount: provider.miradores.length,
                  itemBuilder: (context, index) {
                    return CardMirador(mirador: provider.miradores[index], tipo: widget.tipo);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}