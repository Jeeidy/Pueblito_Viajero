import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/provider/screen_iniciar_sesion_provider.dart';
import '../../../../provider/panel_mirador_provider.dart';
import '../fragmentos/secciones/imagenes_mirador.dart';

class ImagenesMiradorSeccionWrapper extends StatefulWidget {
  const ImagenesMiradorSeccionWrapper({super.key});

  @override
  _ImagenesMiradorSeccionWrapperState createState() =>
      _ImagenesMiradorSeccionWrapperState();
}

class _ImagenesMiradorSeccionWrapperState
    extends State<ImagenesMiradorSeccionWrapper> {
  late PageController _pageController;
  Timer? _timer;
  final List<String> defaultImages = [
    'assets/imagen_vacia.jpg',
    'assets/imagen_vacia.jpg',
    'assets/imagen_vacia.jpg',
    'assets/imagen_vacia.jpg',
    'assets/imagen_vacia.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      if (!mounted) return; // Verifica si el State está montado

      final provider = Provider.of<PanelMiradorProvider>(context, listen: false);
      final providerSesion =
      Provider.of<IniciarSesionProvider>(context, listen: false);

      final images = provider.mirador.images.isNotEmpty
          ? provider.mirador.images
          : providerSesion.mirador.images.isNotEmpty
          ? providerSesion.mirador.images
          : defaultImages;

      int nextPage = provider.currentImageIndex < images.length - 1
          ? provider.currentImageIndex + 1
          : 0;
      provider.actualizarImagen(nextPage);

      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PanelMiradorProvider>(context);
    final sesionProvider = Provider.of<IniciarSesionProvider>(context);

    final images = provider.mirador.images.isNotEmpty
        ? provider.mirador.images
        : sesionProvider.mirador.images.isNotEmpty
        ? sesionProvider.mirador.images
        : defaultImages;

    return ImagenesMiradorSeccion(
      pageController: _pageController,
      images: images,
    );
  }
}