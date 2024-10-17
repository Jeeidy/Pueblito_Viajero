import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/provider/screen_iniciar_sesion_provider.dart';
import 'package:pueblito_viajero/servicios/mirador_servicio.dart';
import 'package:pueblito_viajero/vistas/android/home/widgets/card_miradores.dart';
import 'package:pueblito_viajero/modelos/mirador_modelo.dart';

class FavoritosFragmento extends StatefulWidget {
  const FavoritosFragmento({super.key});

  @override
  _FavoritosFragmentoState createState() => _FavoritosFragmentoState();
}

class _FavoritosFragmentoState extends State<FavoritosFragmento> {
  late List<MiradorModel> favoritos = [];
  final MiradorService _miradorService = MiradorService();

  @override
  void initState() {
    super.initState();
    _cargarFavoritos();
  }

  Future<void> _cargarFavoritos() async {
    final sesionProvider = Provider.of<IniciarSesionProvider>(context, listen: false);
    final userId = sesionProvider.usuario.id;
    favoritos = await _miradorService.obtenerFavoritosDirectamente(userId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            'FAVORITOS',
            style: GoogleFonts.inter(
              fontSize: 33,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Expanded(
          flex: 10,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListView.builder(
              itemCount: favoritos.length,
              itemBuilder: (context, index) {
                return CardMirador(mirador: favoritos[index], tipo: 'user');
              },
            ),
          ),
        ),
      ],
    );
  }
}