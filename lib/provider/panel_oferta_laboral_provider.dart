import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../modelos/oferta_laboral_modelo.dart';
import '../servicios/mirador_servicio.dart';
import '../servicios/oferta_laboral_servicio.dart';
import 'screen_iniciar_sesion_provider.dart';

class OfertaLaboralProvider with ChangeNotifier {
  dynamic image;
  bool isLoading = false;
  bool isDeleting = false;
  bool isUpload = false;
  List<String> _imageUrls = [];
  bool _isSliderLoading = true;
  final PageController _pageController = PageController();
  int _currentPage = 0;

  OfertaLaboralService _ofertaLaboralService = OfertaLaboralService();
  MiradorService _miradorService = MiradorService();


  List<String> get imageUrls => _imageUrls;
  bool get isSliderLoading => _isSliderLoading;
  PageController get pageController => _pageController;

  OfertaLaboralProvider(BuildContext context) {
    _fetchOfertasLaborales(context);
    _startAutoSlide();
  }

  void updateCurrentPage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  Future<void> pickImageFromGallery() async {
    if (kIsWeb) {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        image = await pickedFile.readAsBytes();
        notifyListeners();
      }
    } else if (Platform.isAndroid && await _isAndroid13OrAbove()) {
      final galleryStatus = await Permission.photos.request();
      if (galleryStatus.isGranted) {
        await _getImageFromGallery();
      } else {
        print('Permiso de galería no concedido.');
      }
    } else {
      final storageStatus = await Permission.storage.request();
      if (storageStatus.isGranted) {
        await _getImageFromGallery();
      } else {
        print('Permiso de almacenamiento no concedido.');
      }
    }
  }

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<bool> _isAndroid13OrAbove() async {
    final version = await Permission.photos.status;
    return version.isGranted;
  }

  Future<void> subirOfertaLaboral(BuildContext context) async {
    if (image == null) {
      print('No hay imagen seleccionada');
      return;
    }

    isLoading = true;
    notifyListeners();

    final sesionProvider = Provider.of<IniciarSesionProvider>(context, listen: false);


    try {
      String userId = sesionProvider.usuario.id;
      String? imageUrl = await _miradorService.uploadImage(userId, image, 'ofertas_laborales_images');

      if (imageUrl != null) {
        OfertaLaboralModel ofertaLaboral = OfertaLaboralModel(userId: userId, imageUrl: imageUrl);
        await _ofertaLaboralService.guardarOfertaLaboral(ofertaLaboral);
        isUpload = true;
        image = null;
        print('Oferta laboral subida exitosamente');

        // Refresh the image URLs
        _imageUrls = await _ofertaLaboralService.obtenerOfertasLaborales(userId);
      } else {
        print('Error al subir la imagen');
      }
    } catch (e) {
      print('Error al subir oferta laboral: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> eliminarOfertaLaboral(BuildContext context) async {
    image = null;
    isDeleting = true;
    notifyListeners();

    final sesionProvider = Provider.of<IniciarSesionProvider>(context, listen: false);

    try {
      String userId = sesionProvider.usuario.id;
      await _ofertaLaboralService.eliminarOfertaLaboral(userId);
      _imageUrls = await _ofertaLaboralService.obtenerOfertasLaborales(userId);
    } catch (e) {
      print('Error al eliminar oferta laboral: $e');
    } finally {
      isDeleting = false;
      notifyListeners();
    }
  }


  Future<void> _fetchOfertasLaborales(BuildContext context) async {
    _isSliderLoading = true;
    notifyListeners();

    final sesionProvider = Provider.of<IniciarSesionProvider>(context, listen: false);
    _imageUrls = await _ofertaLaboralService.obtenerOfertasLaborales(sesionProvider.usuario.id);
    _isSliderLoading = false;
    notifyListeners();
  }

  void _startAutoSlide() {
    Future.delayed(const Duration(seconds: 10), () {
      if (_pageController.hasClients) {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        _startAutoSlide();
      }
    });
  }
}