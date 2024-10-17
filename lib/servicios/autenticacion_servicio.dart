import 'package:firebase_auth/firebase_auth.dart';

import '../modelos/usuario_model.dart';


class AutenticacionService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UsuarioModel?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        return UsuarioModel(
          id: user.uid,
          email: user.email ?? '',
          password: '',
          name: '',
          image: null,
          isAdmin: false,
          isUser: false,
          phone: '',
        );
      }
    } on FirebaseAuthException catch (e) {
      // Re-throw the FirebaseAuthException to be caught in the provider
      throw e;
    } catch (e) {
      print('Error during login: $e');
    }
    return null;
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  Future<String?> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      print('Error sending password reset email: $e');
      return 'unknown-error';
    }
  }
}