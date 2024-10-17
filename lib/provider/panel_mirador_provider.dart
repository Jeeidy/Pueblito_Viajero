import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../modelos/mirador_modelo.dart';
import '../servicios/mirador_servicio.dart';
import '../servicios/almacenamiento_servicio.dart';
import '../utils/funciones/funcion_galeria_modelo.dart';
import 'screen_iniciar_sesion_provider.dart';

class PanelMiradorProvider with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController serviciosController = TextEditingController();
  final TextEditingController mapaController = TextEditingController();
  final TextEditingController horario1Controller = TextEditingController(text: '00:00');
  final TextEditingController horario2Controller = TextEditingController(text: '00:00');
  final TextEditingController horario3Controller = TextEditingController(text: '00:00');
  final TextEditingController horario4Controller = TextEditingController(text: '00:00');

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();
  final FocusNode addressFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode instagramFocusNode = FocusNode();
  final FocusNode facebookFocusNode = FocusNode();
  final FocusNode serviciosFocusNode = FocusNode();
  final FocusNode horario1FocusNode = FocusNode();
  final FocusNode horario2FocusNode = FocusNode();
  final FocusNode horario3FocusNode = FocusNode();
  final FocusNode horario4FocusNode = FocusNode();
  final FocusNode mapaFocusNode = FocusNode();

  final ImagePickerService _imagePickerService = ImagePickerService();
  final MiradorService _miradorService = MiradorService();

  late List<String?> horarios = List.filled(2, '');

  PanelMiradorProvider() {
    nameController.text = mirador.name;
    descriptionController.text = mirador.description;
    addressController.text = mirador.address;
    phoneController.text = mirador.phone;
    emailController.text = mirador.email;
    instagramController.text = mirador.instagram;
    facebookController.text = mirador.facebook;
    serviciosController.text = mirador.servicios.join('\n');

    horario1Controller.addListener(() => formatTime(horario1Controller));
    horario2Controller.addListener(() => formatTime(horario2Controller));
    horario3Controller.addListener(() => formatTime(horario3Controller));
    horario4Controller.addListener(() => formatTime(horario4Controller));

    horario1FocusNode.addListener(() => clearOnFocus(horario1Controller, horario1FocusNode));
    horario2FocusNode.addListener(() => clearOnFocus(horario2Controller, horario2FocusNode));
    horario3FocusNode.addListener(() => clearOnFocus(horario3Controller, horario3FocusNode));
    horario4FocusNode.addListener(() => clearOnFocus(horario4Controller, horario4FocusNode));
  }

  final StorageService _storageService = StorageService();

  int currentImageIndex = 0;
  List<dynamic> tempImages = [];
  String imagenUrl = '';
  List<String> imagenesUrl = [];
  String horario1AmPm = 'AM';
  String horario2AmPm = 'AM';
  String horario3AmPm = 'AM';
  String horario4AmPm = 'AM';
  final ImagePicker _picker = ImagePicker();

  bool isLoading = false;
  bool registrarCheck = false;
  bool imagenCheck = false;
  bool imagenEdit = false;
  bool imagenesCheck = false;
  bool imagenesEdit = false;
  bool contactoCheck = false;
  bool contactoEdit = false;
  bool serviciosCheck = false;
  bool serviciosEdit = false;
  bool horarioCheck = false;
  bool horarioEdit = false;
  bool mapaCheck = false;
  bool mapaEdit = false;
  bool nombreDescripcionCheck = false;
  bool nombreDescripcionEdit= false;

  MiradorModel mirador = MiradorModel(
    id: '',
    userId: '',
    name: '',
    description: '',
    image: '',
    images: [],
    address: '',
    phone: '',
    email: '',
    instagram: '',
    facebook: '',
    servicios: [],
    hora: ['', ''],
    mapa: '',
  );

  void agregarValor(TextEditingController controller, String tipo) {
    String valor = controller.text;
    if (valor.isNotEmpty) {
      switch (tipo) {
        case 'name':
          mirador.actualizarNombre(valor);
          break;
        case 'description':
          mirador.actualizarDescripcion(valor);
          break;
        case 'address':
          mirador.actualizarDireccion(valor);
          break;
        case 'phone':
          mirador.actualizarTelefono(valor);
          break;
        case 'email':
          mirador.actualizarEmail(valor);
          break;
        case 'instagram':
          mirador.actualizarInstagram(valor);
          break;
        case 'facebook':
          mirador.actualizarFacebook(valor);
          break;
        case 'mapa':
          mirador.actualizarMapa(valor);
          break;
      }
      controller.clear();
    }
  }

  Map<String, dynamic> collectMiradorData() {
    return {
      'userId': mirador.userId,
      'name': mirador.name,
      'description': mirador.description,
      'image': mirador.image,
      'images': mirador.images,
      'address': mirador.address,
      'phone': mirador.phone,
      'email': mirador.email,
      'instagram': mirador.instagram,
      'facebook': mirador.facebook,
      'servicios': mirador.servicios,
      'hora': mirador.hora,
      'mapa': mirador.mapa,
    };
  }

  Future<void> pickImagesFromGallery() async {
    cambiarMarcaImagenesEdit();
    final images = await pickMultipleImages();
    if (images != null && images.length <= 5) {
      List<dynamic> imageFiles = [];

      for (var image in images) {
        if (image is XFile) {
          final bytes = await image.readAsBytes();
          imageFiles.add(bytes);
        } else if (image is String) {
        } else {
          throw Exception('Unsupported image type');
        }
      }
      mirador.actualizarImagenes(imageFiles);
      notifyListeners();
    } else {
    }
  }

  Future<List<XFile>?> pickMultipleImages() async {
    try {
      final List<XFile>? images = await _picker.pickMultiImage();
      return images;
    } catch (e) {
      return null;
    }
  }

  void deleteAllImages() {
    imagenesCheck = false;
    mirador.actualizarImagenes([]);
    tempImages.clear();
    notifyListeners();
  }

  void extraerServicios(TextEditingController controller) {
    final text = controller.text;
    final lines = text.split('\n').map((line) => line.trim()).where((line) => line.isNotEmpty).toList();
    final List<String?> servicios = List.filled(10, '');

    for (int i = 0; i < lines.length && i < 10; i++) {
      servicios[i] = lines[i];
    }

    mirador.servicios = servicios;
    notifyListeners();
  }

  Future<void> pickImageFromGallery(BuildContext context) async {
    await _imagePickerService.pickImageFromGallery(mirador);
    notifyListeners();
  }

  void formatTime(TextEditingController controller) {
    String text = controller.text.replaceAll(RegExp(r'[^0-9]'), '');
    int selectionIndex = controller.selection.start;

    if (text.length > 4) {
      text = text.substring(0, 4);
    }

    if (text.length >= 2) {
      text = '${text.substring(0, 2)}:${text.substring(2)}';
      if (selectionIndex == 3) {
        selectionIndex++;
      }
    }

    if (selectionIndex > text.length) {
      selectionIndex = text.length;
    }

    controller.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }

  Future<void> registrarMirador(BuildContext context) async {
    final sesionProvider = Provider.of<IniciarSesionProvider>(context, listen: false);
    isLoading = true;
    registrarCheck = true;
    notifyListeners();
    try {
      await _miradorService.registrarMirador(context, mirador);
      sesionProvider.tieneMirador =  true;
    } catch (e) {
      print('Error al registrar mirador: $e');
    } finally {
      nombreDescripcionCheck = false;
      imagenCheck = false;
      imagenesCheck = false;
      contactoCheck = false;
      serviciosCheck = false;
      horarioCheck = false;
      mapaCheck = false;
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> actualizarMirador(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      Map<String, dynamic> updatedData = {};

      if (nombreDescripcionCheck) {
        updatedData['name'] = mirador.name;
        updatedData['description'] = mirador.description;
      }
      if (imagenCheck) {
        updatedData['image'] = mirador.image;
      }
      if (imagenesCheck) {
        updatedData['images'] = mirador.images;
      }
      if (contactoCheck) {
        updatedData['address'] = mirador.address;
        updatedData['phone'] = mirador.phone;
        updatedData['email'] = mirador.email;
        updatedData['instagram'] = mirador.instagram;
        updatedData['facebook'] = mirador.facebook;
      }
      if (serviciosCheck) {
        updatedData['servicios'] = mirador.servicios;
      }
      if (horarioCheck) {
        updatedData['hora'] = mirador.hora;
      }


      await _miradorService.actualizarMirador(context, updatedData);

    } catch (e) {
      print('Error updating mirador: $e');
    } finally {
      nombreDescripcionCheck = false;
      imagenCheck = false;
      imagenesCheck = false;
      contactoCheck = false;
      serviciosCheck = false;
      horarioCheck = false;
      mapaCheck = false;
      isLoading = false;
      notifyListeners();
    }
  }

  void extraerHorarios(TextEditingController controllerHorario1,
                       TextEditingController controllerHorario2,
                       TextEditingController controllerHorario3,
                       TextEditingController controllerHorario4) {
    final text1 = '${controllerHorario1.text.isEmpty ? '00:00' : controllerHorario1.text} $horario1AmPm';
    final text2 = '${controllerHorario2.text.isEmpty ? '00:00' : controllerHorario2.text} $horario2AmPm';
    final text3 = '${controllerHorario3.text.isEmpty ? '00:00' : controllerHorario3.text} $horario3AmPm';
    final text4 = '${controllerHorario4.text.isEmpty ? '00:00' : controllerHorario4.text} $horario4AmPm';

    horarios[0] = '$text1 - $text2';
    horarios[1] = '$text3 - $text4';

    mirador.hora = horarios;
    notifyListeners();
  }

  void clearOnFocus(TextEditingController controller, FocusNode focusNode) {
    if (focusNode.hasFocus) {
      controller.clear();
    }
  }

  void setHorario1AmPm(String value) {
    horario1AmPm = value;
    notifyListeners();
  }

  void setHorario2AmPm(String value) {
    horario2AmPm = value;
    notifyListeners();
  }

  void setHorario3AmPm(String value) {
    horario3AmPm = value;
    notifyListeners();
  }

  void setHorario4AmPm(String value) {
    horario4AmPm = value;
    notifyListeners();
  }

  void eliminarImagen() {
    imagenCheck = false;
    mirador.image = null;
    imagenCheck = false;
    notifyListeners();
  }

  void cambiarMarca() {
    imagenCheck = false;
    imagenCheck ? imagenCheck : imagenCheck = !imagenCheck;
    notifyListeners();
  }

  void cambiarMarcaImagenEdit() {
    imagenEdit = false;
    registrarCheck = false;
    imagenCheck = false;
    imagenEdit = !imagenEdit;
    notifyListeners();
  }

  void cambiarMarcaNombre() {
    nombreDescripcionEdit = false;
    nombreDescripcionCheck ? nombreDescripcionCheck : nombreDescripcionCheck = !nombreDescripcionCheck;
    notifyListeners();
  }

  void cambiarMarcaNombreEdit() {
    nombreDescripcionCheck = false;
    nombreDescripcionEdit = !nombreDescripcionEdit;
    notifyListeners();
  }

  void cambiarMarcaImagenes() {
    imagenesEdit = false;
    imagenesCheck ? imagenesCheck : imagenesCheck = !imagenesCheck;
    notifyListeners();
  }

  void cambiarMarcaImagenesEdit() {
    imagenesCheck = false;
    imagenesEdit = !imagenesEdit;
    notifyListeners();
  }

  void cambiarMarcaContacto() {
    contactoEdit = false;
    contactoCheck = !contactoCheck;
    contactoCheck ? contactoCheck : contactoCheck = !contactoCheck;
    notifyListeners();
  }

  void cambiarMarcaContactoEdit() {
    contactoCheck = false;
    contactoEdit = !contactoEdit;
    notifyListeners();
  }

  void cambiarMarcaServicios() {
    serviciosEdit = false;
    serviciosCheck = !serviciosCheck;
    serviciosCheck ? serviciosCheck : serviciosCheck = !serviciosCheck;
    notifyListeners();
  }

  void cambiarMarcaServiciosEdit() {
    serviciosCheck = false;
    serviciosEdit = !serviciosEdit;
    notifyListeners();
  }

  void cambiarMarcaHorario() {
    horarioEdit = false;
    horarioCheck = !horarioCheck;
    notifyListeners();
  }

  void cambiarMarcaHorarioEdit() {
    horarioCheck = false;
    horarioEdit = !horarioEdit;
    notifyListeners();
  }

  void actualizarImagen(int index) {
    currentImageIndex = index;
    notifyListeners();
  }

  void cambiarMarcaMapa() {
    mapaEdit = false;
    mapaCheck ? mapaCheck : mapaCheck = !mapaCheck;
    notifyListeners();
  }

  void cambiarMarcaMapaEdit() {
    mapaCheck = false;
    mapaEdit = !mapaEdit;
    notifyListeners();
  }
}