import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/fragmento_miradores_provider.dart';
import '../../../../utils/custom/custom_colors.dart';
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
                    return CardMirador(
                      mirador: provider.miradores[index],
                      tipo: widget.tipo
                    );
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


class BarraBusqueda extends StatelessWidget {
  const BarraBusqueda({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
      child: TextField(
        onChanged: (value) {
          Provider.of<MiradoresFragmentoProvider>(context, listen: false).buscarMiradores(value.toLowerCase());
        },
        decoration: InputDecoration(
          hintText: 'Buscar mirador...',
          hintStyle: const TextStyle(color: Colors.white),
          prefixIcon: const Icon(Icons.search, color: Colors.black),
          filled: true,
          fillColor: AppColors.verdeDivertido,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: AppColors.verdeDivertido, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: AppColors.verdeDivertido, width: 2),
          ),
        ),
      ),
    );
  }
}
