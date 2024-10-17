import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../servicios/usuario_servicio.dart';
import 'screen_iniciar_sesion_provider.dart';

class PerfilProvider with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController letraController = TextEditingController();

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode telefonoFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode letraFocusNode = FocusNode();

  int _selectedOption = 0;
  bool isLoading = false;

  int get selectedOption => _selectedOption;

  final RegistroService _usuarioService = RegistroService();

  void updateSelectedOption(int option) {
    _selectedOption = option;
    notifyListeners();
  }

  Future<void> actualizarUsuario(BuildContext context, String name, String phone) async {
    isLoading = true;
    notifyListeners();

    final sesionProvider = Provider.of<IniciarSesionProvider>(context, listen: false);
    await _usuarioService.actualizarUsuario(sesionProvider.usuario.id, name, phone);
    sesionProvider.usuario.name = name;
    sesionProvider.usuario.phone = phone;

    isLoading = false;
    notifyListeners();
  }
}