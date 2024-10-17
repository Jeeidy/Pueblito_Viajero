import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/provider/screen_iniciar_sesion_provider.dart';
import 'package:pueblito_viajero/servicios/almacenamiento_servicio.dart';
import '../modelos/mirador_modelo.dart';
import '../provider/panel_mirador_provider.dart';

class MiradorService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageService _storageService = StorageService();

  String documentId = '';

  Future<void> registrarMirador(BuildContext context, MiradorModel mirador) async {
    try {
      final sesionProvider = Provider.of<IniciarSesionProvider>(context, listen: false);
      final miradorProvider = Provider.of<PanelMiradorProvider>(context, listen: false);
      String userId = sesionProvider.usuario.id;
      await _guardarDatosMirador(userId, mirador);
      String? imageUrl;
      if (mirador.image != null) {
        imageUrl = await _storageService.uploadImage(documentId, mirador.image, 'mirador_images');
        miradorProvider.imagenUrl = imageUrl!;
      }
      List<String>? imageUrls = [];
      if (mirador.images != null) {
        imageUrls =
          (await _storageService.uploadImages(documentId, mirador.images, 'mirador_images')).cast<String>();
      }
      miradorProvider.imagenesUrl = imageUrls;
      await _firestore.collection('Miradores').doc(documentId).update({
        'image': imageUrl,
        'images': imageUrls,
      });
    } catch (e) {
      print('Error al registrar mirador: $e');
    }
  }

  Future<void> _guardarDatosMirador(String userId, MiradorModel mirador) async {
    try {
      DocumentReference docRef = await _firestore.collection('Miradores').add({
        'userId': userId,
        'name': mirador.name,
        'description': mirador.description,
        'address': mirador.address,
        'phone': mirador.phone,
        'email': mirador.email,
        'instagram': mirador.instagram,
        'facebook': mirador.facebook,
        'servicios': mirador.servicios,
        'hora': mirador.hora,
        'mapa': mirador.mapa,
      });
      documentId = docRef.id;
    } catch (e) {
      print('Error al guardar datos del mirador: $e');
    }
  }

  Future<String?> uploadImage(String userId, dynamic image, String carpeta) async {
    return await _storageService.uploadImage(userId, image, carpeta);
  }

  Future<void> actualizarMirador(BuildContext context, Map<String, dynamic> updatedData) async {
    final sesionProvider = Provider.of<IniciarSesionProvider>(context, listen: false);
    final miradorProvider = Provider.of<PanelMiradorProvider>(context, listen: false);
    try {
      QuerySnapshot query = await _firestore.collection('Miradores')
          .where('userId', isEqualTo: sesionProvider.mirador.userId)
          .limit(1)
          .get();
      if (query.docs.isNotEmpty) {
        DocumentReference docRef = query.docs.first.reference;

        if (updatedData.containsKey('image') && miradorProvider.mirador.image != null) {
          String? imageUrl = await _storageService.uploadImage(docRef.id, miradorProvider.mirador.image, 'mirador_images');
          updatedData['image'] = imageUrl;
        }
        if (updatedData.containsKey('images') && miradorProvider.mirador.images.isNotEmpty) {
          List<String?> imageUrls = await _storageService.uploadImages(docRef.id, miradorProvider.mirador.images, 'mirador_images');
          imageUrls.removeWhere((url) => url == null);
          DocumentSnapshot docSnapshot = await docRef.get();
          Map<String, dynamic> docData = docSnapshot.data() as Map<String, dynamic>;
          List<String> existingImages = List<String>.from(docData['images'] ?? []);
          for (int i = 0; i < imageUrls.length && i < 5; i++) {
            if (i < existingImages.length) {
              existingImages[i] = imageUrls[i]!;
            } else {
              existingImages.add(imageUrls[i]!);
            }
          }
          updatedData['images'] = existingImages.sublist(0, 5);
        }

        if (miradorProvider.mapaCheck) {
          updatedData['mapa'] = miradorProvider.mirador.mapa;
        }
        await docRef.update(updatedData);
      }
    } catch (e) {
      print('Error al actualizar mirador: $e');
    }
  }

  Future<void> actualizarFavoritos(String miradorId, String userId) async {
    try {
      DocumentReference docRef = _firestore.collection('Miradores').doc(miradorId);
      await docRef.update({
        'favoritos': FieldValue.arrayUnion([userId]),
      });
    } catch (e) {
      print('Error al actualizar favoritos: $e');
    }
  }

  Future<void> eliminarFavorito(String miradorId, String userId) async {
    try {
      DocumentReference docRef = _firestore.collection('Miradores').doc(miradorId);
      await docRef.update({
        'favoritos': FieldValue.arrayRemove([userId]),
      });
    } catch (e) {
      print('Error al eliminar favorito: $e');
    }
  }

  Future<void> agregarCalificacion(String miradorId, String userId, int calificacion) async {
    try {
      DocumentReference docRef = _firestore.collection('Miradores').doc(miradorId);
      await docRef.update({
        'calificaciones.$userId': calificacion,
      });
    } catch (e) {
      print('Error al agregar calificación: $e');
    }
  }

  Future<List<MiradorModel>> obtenerMiradores() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('Miradores').get();
      return querySnapshot.docs.map((doc) =>
        MiradorModel.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
    } catch (e) {
      print('Error al obtener miradores: $e');
      return [];
    }
  }

  Future<List<MiradorModel>> buscarMiradoresPorNombre(String nombre) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('Miradores').get();
      String nombreLower = nombre.toLowerCase();
      return querySnapshot.docs
          .map((doc) => MiradorModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .where((mirador) => mirador.name.toLowerCase().contains(nombreLower))
          .toList();
    } catch (e) {
      print('Error al buscar miradores: $e');
      return [];
    }
  }

  Future<List<MiradorModel>> obtenerFavoritosDirectamente(String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('Miradores')
          .where('favoritos', arrayContains: userId)
          .get();
      return querySnapshot.docs.map((doc) =>
          MiradorModel.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
    } catch (e) {
      print('Error al obtener favoritos: $e');
      return [];
    }
  }
}