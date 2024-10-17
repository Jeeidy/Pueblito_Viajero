import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pueblito_viajero/servicios/almacenamiento_servicio.dart';
import '../modelos/evento_modelo.dart';

class EventoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageService _storageService = StorageService();

  Future<void> actualizarEvento(String userId, EventoModel evento) async {
    try {
      String? imageUrl;
      if (evento.image != null) {
        imageUrl = await _storageService.uploadImage(userId, evento.image, 'event_images');
        evento.actualizarImagen(imageUrl);
      }

      await _firestore.collection('Eventos').add({
        'userId': userId,
        'nombre': evento.nombre,
        'precio': evento.precio,
        'hora': evento.hora,
        'descripcion': evento.descripcion,
        'image': imageUrl,
        'fecha': evento.fecha?.toIso8601String(), // Asegurarse de guardar la fecha
      });
    } catch (e) {
      print('Error al actualizar evento: $e');
    }
  }

  Future<List<EventoModel>> obtenerEventos() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('Eventos').get();
      return querySnapshot.docs.map((doc) => EventoModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      print('Error al obtener eventos: $e');
      return [];
    }
  }

  Future<void> eliminarEvento(String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Eventos')
          .where('userId', isEqualTo: userId)
          .get();

      for (var doc in querySnapshot.docs) {
        await _firestore.collection('Eventos').doc(doc.id).delete();
      }
    } catch (e) {
      print('Error al eliminar evento: $e');
    }
  }
}