import '../modelos/mirador_modelo.dart';
import '../servicios/mirador_servicio.dart';
import 'package:flutter/material.dart';

class MiradoresFragmentoProvider with ChangeNotifier {
  List<MiradorModel> _miradores = [];
  final MiradorService _miradorService = MiradorService();

  List<MiradorModel> get miradores => _miradores;

  Future<void> cargarMiradores() async {
    _miradores = await _miradorService.obtenerMiradores();
    notifyListeners();
  }

  Future<void> buscarMiradores(String nombre) async {
    _miradores = await _miradorService.buscarMiradoresPorNombre(nombre);
    notifyListeners();
  }

  Future<void> agregarFavorito(String miradorId, String userId) async {
    await _miradorService.actualizarFavoritos(miradorId, userId);
    await cargarMiradores();
  }

  Future<void> eliminarFavorito(String miradorId, String userId) async {
    await _miradorService.eliminarFavorito(miradorId, userId);
    await cargarMiradores();
  }

  List<MiradorModel> obtenerFavoritos(String userId) {
    return _miradores.where((mirador) => mirador.favoritos.contains(userId)).toList();
  }

  Future<void> agregarCalificacion(String miradorId, String userId, int calificacion) async {
    await _miradorService.agregarCalificacion(miradorId, userId, calificacion);
    await cargarMiradores();
  }
}