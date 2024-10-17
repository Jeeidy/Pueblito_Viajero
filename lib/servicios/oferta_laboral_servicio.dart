import 'package:cloud_firestore/cloud_firestore.dart';
import '../modelos/oferta_laboral_modelo.dart';

class OfertaLaboralService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> guardarOfertaLaboral(OfertaLaboralModel ofertaLaboral) async {
    try {
      QuerySnapshot query = await _firestore.collection('OfertasLaborales')
          .where('userId', isEqualTo: ofertaLaboral.userId)
          .limit(1)
          .get();

      if (query.docs.isEmpty) {
        await _firestore.collection('OfertasLaborales').add(ofertaLaboral.toMap());
      } else {
        print('Ya existe una oferta laboral para este usuario');
      }
    } catch (e) {
      print('Error al guardar oferta laboral: $e');
    }
  }

  Future<List<String>> obtenerOfertasLaborales(String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('OfertasLaborales')
          .where('userId', isEqualTo: userId)
          .get();
      List<String> imageUrls = querySnapshot.docs.map((doc) => doc['imageUrl'] as String).toList();
      return imageUrls;
    } catch (e) {
      print('Error al obtener ofertas laborales: $e');
      return [];
    }
  }

  Future<List<String>> obtenerTodasLasOfertasLaborales() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('OfertasLaborales').get();
      List<String> imageUrls = querySnapshot.docs.map((doc) => doc['imageUrl'] as String).toList();
      return imageUrls;
    } catch (e) {
      print('Error al obtener todas las ofertas laborales: $e');
      return [];
    }
  }

  Future<void> eliminarOfertaLaboral(String userId) async {
    try {
      QuerySnapshot query = await _firestore.collection('OfertasLaborales')
          .where('userId', isEqualTo: userId)
          .get();

      for (var doc in query.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      print('Error al eliminar oferta laboral: $e');
    }
  }
}