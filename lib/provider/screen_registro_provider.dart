import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../modelos/usuario_model.dart';
import '../servicios/usuario_servicio.dart';
import '../utils/custom/custom_colors.dart';
import '../utils/funciones/funcion_galeria_modelo.dart';
import '../vistas/android/iniciar_sesion/iniciar_sesion_screen.dart';
import 'screen_iniciar_sesion_provider.dart';

class RegistroProvider with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  bool isLoading = false;
  bool capturaInfo = false;
  bool isPasswordVisible = false;

  final RegistroService _registroService = RegistroService();
  final ImagePickerService _imagePickerService = ImagePickerService();

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
        case 'name':
          usuario.actualizarNombre(valor);
          break;
        case 'phone':
          usuario.actualizarNombre(valor);
          break;
      }
      controller.clear();
    }
  }

  void siguiente(BuildContext context) {
    Navigator.pushNamed(context, '/crear_cuenta_2');
  }

  void siguiente2(BuildContext context) {
    Navigator.pushNamed(context, '/cargar_imagen');
  }

  void siguienteWeb() {
    capturaInfo = false;
    capturaInfo = !capturaInfo;
    notifyListeners();
  }

  void siguienteWebFalse() {
    capturaInfo = false;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  Future<void> pickImageFromCamera() async {
    final cameraStatus = await Permission.camera.request();

    if (cameraStatus.isGranted) {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        usuario.image = File(pickedFile.path);
        notifyListeners();
      }
    } else {
      print('Permiso de cámara no concedido.');
    }
  }

  Future<void> pickImageFromGallery() async {
    await _imagePickerService.pickImageFromGallery(usuario);
    notifyListeners();
  }

  Future<void> registrarUsuario(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    User? user = await _registroService.registrarUsuario(usuario, 1);
    isLoading = false;
    notifyListeners();
    if (user != null) {
      if (kIsWeb) {
        final sesionProvider = Provider.of<IniciarSesionProvider>(context, listen: false);
        sesionProvider.toggleAuthProcess();
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PantallaIniciarSesion()),
        );
      }
      usuario.image = null;
    } else {
      print('Error al registrar usuario');
    }
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }
  bool isValidName(String name) {
    return name.isNotEmpty;
  }

  bool isValidPassword(String password) {
    return password.length >= 8;
  }

  void showErrorDialog(BuildContext context, String message, String type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: type == 'email' ? const Text('Estructura invalida') :
                 type == 'empty' ? const Text('Campo Vacio') :
                 type == 'caracter' ? const Text('Contraseña invalida') : null,
          content: Text(message, style: const TextStyle(fontSize: 16)),
          actions:  <Widget>[
            TextButton(
              child: const Text('OK', style: TextStyle(color: kIsWeb ? AppColors.azulClaro : AppColors.verdeDivertido)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void limpiarImagen() {
    usuario.image = null;
    notifyListeners();
  }

  void disposeControllers() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    nameFocusNode.dispose();
  }
}



