import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../modelos/usuario_model.dart';


class AutenticacionService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '315768036614-j85o5g930d6vvrs9abe15spml8amurg8.apps.googleusercontent.com',
  );

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
      throw e;
    } catch (e) {
      print('Error during login: $e');
    }
    return null;
  }

  Future<UsuarioModel?> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // El usuario canceló el inicio de sesión
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        return UsuarioModel(
          id: user.uid,
          email: user.email ?? '',
          password: '12345678',
          name: user.displayName ?? '',
          image: user.photoURL,
          isAdmin: false,
          isUser: true,
          phone: user.phoneNumber ?? '',
        );
      }
    } on FirebaseAuthException catch (e) {
      throw e;
    } catch (e) {
      print('Error during Google login: $e');
    }
    return null;
  }

  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
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