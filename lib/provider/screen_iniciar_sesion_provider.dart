import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/modelos/mirador_modelo.dart';
import 'package:pueblito_viajero/vistas/android/iniciar_sesion/iniciar_sesion_screen.dart';
import 'package:pueblito_viajero/vistas/web/sesion_registro/sesion_registro_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../modelos/usuario_model.dart';
import '../servicios/autenticacion_servicio.dart';
import '../servicios/usuario_servicio.dart';
import '../vistas/android/bienvenida/bienvenida_screen.dart';
import '../vistas/android/start/start_screen.dart';
import 'fragmento_home_provider.dart';

class IniciarSesionProvider with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  bool isLoading = false;
  bool isLoading_2 = false;
  bool isForgetPassword = false;
  bool authProcess = false;
  bool tieneMirador = false;
  bool isPasswordVisible = true;

  final RegistroService _registroService = RegistroService();
  final AutenticacionService _autenticacionService = AutenticacionService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UsuarioModel usuario = UsuarioModel(
                          id: '',
                          email: '',
                          password: '',
                          name: '',
                          image: null,
                          isAdmin: false,
                          isUser: false,
                          phone: '',
                        );

  MiradorModel mirador = MiradorModel(
                          id: '',
                          userId: '',
                          name: '',
                          description: '',
                          address: '',
                          image: '',
                          phone: '',
                          email: '',
                          instagram: '',
                          facebook: '',
                          servicios: [],
                          hora: [],
                          mapa: '',
  );

  void agregarValor(TextEditingController controller, String tipo) {
    String valor = controller.text;
    if (valor.isNotEmpty) {
      switch (tipo) {
        case 'email':
          usuario.actualizarEmail(valor);
          break;
        case 'password':
          usuario.actualizarPassword(valor);
          break;
      }
      controller.clear();
    }
  }

  Future<void> login(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      UsuarioModel? user = await _autenticacionService.login(
        usuario.email,
        usuario.password,
      );

      if (user != null) {
        usuario = user;
        await fetchUserDataFromFirestore(user.id);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userId', user.id);

        isLoading = false;
        notifyListeners();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const BienvenidaPage()),
              (Route<dynamic> route) => false,
        );
      } else {
        isLoading = false;
        notifyListeners();
        showErrorDialog(context, 'Error desconocido. Inténtalo de nuevo.', 'error');
      }
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      if (e.code == 'user-not-found') {
        showErrorDialog(context, 'El correo electrónico no está registrado.', 'email');
      } else if (e.code == 'wrong-password') {
        showErrorDialog(context, 'La contraseña es incorrecta.', 'password');
      } else if (e.code == 'invalid-credential') {
        showErrorDialog(context, 'Las credenciales proporcionadas son incorrectas, el correo o contraseña no coinciden con la base de datos.', 'credential');
      } else {
        showErrorDialog(context, 'Error desconocido. Inténtalo de nuevo.', 'error');
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      showErrorDialog(context, 'Error desconocido. Inténtalo de nuevo.', 'error');
    }
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      UsuarioModel? user = await _autenticacionService.loginWithGoogle();
      usuario = user!;

      if (user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userId', user.id);
        await _registroService.registrarUsuario(usuario, 2);

        isLoading = false;
        notifyListeners();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const BienvenidaPage()),
              (Route<dynamic> route) => false,
        );
      } else {
        isLoading = false;
        notifyListeners();
        showErrorDialog(context, 'Inicio de sesión cancelado o fallido.', 'error');
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      showErrorDialog(context, 'Error durante el inicio de sesión con Google.', 'error');
    }
  }

  void showErrorDialog(BuildContext context, String message, String type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: type == 'email' ? const Text('Correo no registrado') :
          type == 'password' ? const Text('Contraseña incorrecta') :
          type == 'credential' ? const Text('Credenciales inválidas') :
          type == 'error' ? const Text('Error') : null,
          content: Text(message, style: const TextStyle(fontSize: 16)),
          actions: <Widget>[
            TextButton(
              child: const Text('OK', style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> logout(BuildContext context) async {
    await _autenticacionService.logout();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('userId');
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.resetVariables();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => kIsWeb ? const PantallaWebSesionRegistro() :const PantallaInicio()),
          (Route<dynamic> route) => false,
    );
  }

  Future<void> fetchUserDataFromFirestore(String userId) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('Usuarios').doc(userId).get();
      if (userDoc.exists) {
        usuario = UsuarioModel.fromMap(userDoc.data() as Map<String, dynamic>);
        usuario.id = userId;

        QuerySnapshot miradorQuery = await _firestore.collection('Miradores')
            .where('userId', isEqualTo: userId)
            .limit(1)
            .get();
        if (miradorQuery.docs.isNotEmpty) {
          tieneMirador = true;
          DocumentSnapshot miradorDoc = miradorQuery.docs.first;
          mirador = MiradorModel.fromMap(miradorDoc.data() as Map<String, dynamic>, miradorDoc.id);
          mirador.userId = userId;
        }
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  void siguiente(BuildContext context) {
    Navigator.pushNamed(context, '/iniciar_contrasenia');
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  void toggleAuthProcess() {
    authProcess = !authProcess;
    notifyListeners();
  }

  void toggleAuthProcessFalse() {
    authProcess = false;
    notifyListeners();
  }

  void cambiarMarcaForgetPassword() {
    isForgetPassword = true;
    notifyListeners();
  }

  void cambiarMarcaForgetPasswordFalse() {
    isForgetPassword = false;
    notifyListeners();
  }

  Future<void> sendPasswordResetEmail(BuildContext context) async {
    isLoading_2 = true;
    notifyListeners();

    String? result = await _autenticacionService.sendPasswordResetEmail(emailController.text);
    isLoading_2 = false;
    notifyListeners();

    if (result == null) {
      showSuccessDialog(context, 'Se ha enviado un enlace de recuperación a tu correo.');
    } else {
      showErrorDialog_2(context, _getErrorMessage(result), result);
    }
  }

  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'El correo electrónico no está registrado.';
      default:
        return 'Error al enviar el enlace de recuperación. Inténtalo de nuevo.';
    }
  }

  void showErrorDialog_2(BuildContext context, String message, String type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: type == 'user-not-found' ? const Text('Correo no registrado') : const Text('Error'),
          content: Text(message, style: const TextStyle(fontSize: 16)),
          actions: <Widget>[
            TextButton(
              child: const Text('OK', style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Éxito'),
          content: Text(message, style: const TextStyle(fontSize: 16)),
          actions: <Widget>[
            TextButton(
              child: const Text('OK', style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

}