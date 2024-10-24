import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:pueblito_viajero/servicios/almacenamiento_servicio.dart';
import '../modelos/usuario_model.dart';

class RegistroService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageService _storageService = StorageService();

  Future<User?> registrarUsuario(UsuarioModel usuario, int tipo) async {
    try {
      User? user;
      if (tipo == 1) {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: usuario.email,
          password: usuario.password,
        );
        user = userCredential.user;
        if (user != null) {
          String? imageUrl;
          if (usuario.image is String) {
            imageUrl = user.photoURL;
          } else {
            if(usuario.image != null){
              imageUrl = await _storageService.uploadImage(user.uid, usuario.image!, 'user_images');
            }

          }

          if (kIsWeb) {
            usuario.isAdmin = true;
          } else if (Platform.isAndroid) {
            usuario.isUser = true;
          }
          await _guardarDatosUsuario(user.uid, usuario, imageUrl);
        }
      } else if (tipo == 2) {
        if (usuario != null) {
          String? imageUrl;
          imageUrl = usuario.image;

          if (kIsWeb) {
            usuario.isAdmin = true;
          } else if (Platform.isAndroid) {
            usuario.isUser = true;
          }
          await _guardarDatosUsuario(usuario.id, usuario, imageUrl);
        }
      }

      return user;
    } catch (e) {
      print('Error al registrar usuario: $e');
      return null;
    }
  }

  Future<void> _guardarDatosUsuario(String uid, UsuarioModel usuario, String? imageUrl) async {
    try {
      await _firestore.collection('Usuarios').doc(uid).set({
        'email': usuario.email,
        'name': usuario.name,
        'phone': usuario.phone,
        'image': imageUrl,
        'isAdmin': usuario.isAdmin,
        'isUser': usuario.isUser,
      });
    } catch (e) {
      print('Error al guardar datos del usuario: $e');
    }
  }

  Future<void> actualizarUsuario(String uid, String name, String phone) async {
    try {
      await _firestore.collection('Usuarios').doc(uid).update({
        'name': name,
        'phone': phone,
      });
    } catch (e) {
      print('Error al actualizar usuario: $e');
    }
  }
}