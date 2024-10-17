import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../modelos/mirador_modelo.dart';
import '../../../../provider/fragmento_miradores_provider.dart';
import '../../../../provider/screen_iniciar_sesion_provider.dart';
import '../fragmentos/secciones/mirador_informacion.dart';

class CardMirador extends StatelessWidget {
  final MiradorModel mirador;
  final String tipo;

  const CardMirador({required this.mirador, required this.tipo, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InformacionMirador(mirador: mirador),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 7),
        child: Card(
          color: Colors.grey[300],
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: double.infinity,
            height: tipo == 'informacion' ? 150 : 180,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(mirador.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            mirador.name,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            mirador.description,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                if (tipo != 'informacion')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InteractiveStars(miradorId: mirador.id),
                      InteractiveFavorite(miradorId: mirador.id, favoritos: mirador.favoritos),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InteractiveStars extends StatefulWidget {
  final String miradorId;

  const InteractiveStars({required this.miradorId, super.key});

  @override
  _InteractiveStarsState createState() => _InteractiveStarsState();
}

class _InteractiveStarsState extends State<InteractiveStars> {
  int _rating = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = Provider.of<IniciarSesionProvider>(context, listen: false).usuario.id;
      final miradorProvider = Provider.of<MiradoresFragmentoProvider>(context, listen: false);
      final mirador = miradorProvider.miradores.firstWhere((m) => m.id == widget.miradorId);
      setState(() {
        _rating = mirador.calificaciones[userId] ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: Icon(
            index < _rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 20,
          ),
          onPressed: () async {
            setState(() {
              _rating = index + 1;
            });
            final userId = Provider.of<IniciarSesionProvider>(context, listen: false).usuario.id;
            final miradorProvider = Provider.of<MiradoresFragmentoProvider>(context, listen: false);
            await miradorProvider.agregarCalificacion(widget.miradorId, userId, _rating);
          },
        );
      }),
    );
  }
}

class InteractiveFavorite extends StatefulWidget {
  final String miradorId;
  final List<String> favoritos;

  const InteractiveFavorite({required this.miradorId, required this.favoritos, super.key});

  @override
  _InteractiveFavoriteState createState() => _InteractiveFavoriteState();
}

class _InteractiveFavoriteState extends State<InteractiveFavorite> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = Provider.of<IniciarSesionProvider>(context, listen: false).usuario.id;
      setState(() {
        _isFavorite = widget.favoritos.contains(userId);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: () async {
        setState(() {
          _isFavorite = !_isFavorite;
        });
        final userId = Provider.of<IniciarSesionProvider>(context, listen: false).usuario.id;
        final miradorProvider = Provider.of<MiradoresFragmentoProvider>(context, listen: false);
        if (_isFavorite) {
          await miradorProvider.agregarFavorito(widget.miradorId, userId);
        } else {
          await miradorProvider.eliminarFavorito(widget.miradorId, userId);
        }
      },
    );
  }
}

