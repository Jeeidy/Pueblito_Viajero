import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../provider/screen_iniciar_sesion_provider.dart';
import '../../../../../provider/panel_mirador_provider.dart';
import '../../widgets/editar.dart';
import 'dart:typed_data';

class ImagenesMiradorSeccion extends StatelessWidget {
  final PageController pageController;
  final List<dynamic> images;

  const ImagenesMiradorSeccion({
    required this.pageController,
    required this.images,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final miradorProvider = Provider.of<PanelMiradorProvider>(context);
    final sesionProvider = Provider.of<IniciarSesionProvider>(context);

    return Card(
      elevation: 3,
      color: Colors.grey[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: PageView.builder(
                  controller: pageController,
                  itemCount: images.length,
                  onPageChanged: (index) {
                    miradorProvider.actualizarImagen(index);
                  },
                  itemBuilder: (context, index) {
                    final image = images[index];

                    // Lógica para determinar el tipo de imagen a mostrar
                    if (image is String && image.startsWith('assets/')) {
                      // Mostrar imagen de assets
                      return Image.asset(
                        image,
                        fit: BoxFit.cover,
                      );
                    } else if (image is Uint8List) {
                      // Mostrar imagen en memoria (Image.memory)
                      return Image.memory(
                        image,
                        fit: BoxFit.cover,
                      );
                    } else if (image is String && image.startsWith('http')) {
                      // Mostrar imagen desde la red (Image.network)
                      return Image.network(
                        image,
                        fit: BoxFit.cover,
                      );
                    } else {
                      return const Center(
                        child: Text('No image available'),
                      );
                    }
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 7,
              right: 10,
              child: EditarWidgetEliminar(
                id: 2,
                onEdit: () {
                  miradorProvider.pickImagesFromGallery();
                },
                onDelete: () {
                  miradorProvider.deleteAllImages();
                },
                onCheck: () {
                  miradorProvider.cambiarMarcaImagenes();
                }, type: 'imagen',
              ),
            ),
          ],
        ),
      ),
    );
  }
}