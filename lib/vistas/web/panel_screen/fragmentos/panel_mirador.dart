import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/fragmentos/secciones/horario.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/fragmentos/secciones/imagenes_mirador.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/fragmentos/secciones/mirador_foto_titulo_descripsion.dart';
import '../../../../provider/screen_iniciar_sesion_provider.dart';
import '../../../../provider/panel_mirador_provider.dart';
import '../widgets/editar.dart';
import '../widgets/card_mapa_stub.dart';
import '../widgets/text_contacto.dart';
import '../widgets/textfield_mirador.dart';

class PanelMirador extends StatelessWidget {
  const PanelMirador({super.key});

  @override
  Widget build(BuildContext context) {
    final miradorProvider = Provider.of<PanelMiradorProvider>(context);
    return Column(
      children: [
        const Expanded(
          flex: 3,
          child: Center(
            child: Text(
              'En este apartado podrás editar la información descriptiva del mirador, por medio del siguiente panel.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          )
        ),
        const Expanded(
          flex: 6,
          child: TituloImagenSeccion()
        ),
        Expanded(
          flex: 10,
          child: Row(
            children: [
              const Expanded(
                flex: 2,
                child: ContactoSeccion()
              ),
              const Expanded(
                flex: 2,
                child: ServiciosSeccion()
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Expanded(child: ImagenesMiradorSeccionWrapper()),
                          Expanded(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Consumer<PanelMiradorProvider>(
                                  builder: (context, provider, child) {
                                    final sesionProvider = Provider.of<IniciarSesionProvider>(context, listen: false);
                                    final mapaSrc = sesionProvider.mirador.mapa.isNotEmpty
                                        ? sesionProvider.mirador.mapa
                                        : provider.mirador.mapa.isNotEmpty
                                        ? provider.mirador.mapa
                                        : '';

                                    return CardGoogleMaps(
                                      src: mapaSrc,
                                      name: provider.mirador.name,
                                    );
                                  },
                                ),
                                Positioned(
                                  bottom: 10,
                                  right: 10,
                                  child: EditarWidgetEliminar(
                                    onEdit: () {
                                      miradorProvider.cambiarMarcaMapaEdit();
                                    },
                                    onCheck: () {
                                      miradorProvider.agregarValor(miradorProvider.mapaController, 'mapa');
                                      miradorProvider.cambiarMarcaMapa();
                                    },
                                    onDelete: () {},
                                    id: 3,
                                    type: 'mapa',
                                  )
                                )
                              ]
                            ),
                          )
                        ],
                      )
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          const HorarioSeccion(),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: EditarWidget(
                              onEdit: () {
                                miradorProvider.cambiarMarcaHorarioEdit();
                              },
                              onCheck: () {
                                miradorProvider.extraerHorarios(
                                    miradorProvider.horario1Controller,
                                    miradorProvider.horario2Controller,
                                    miradorProvider.horario3Controller,
                                    miradorProvider.horario4Controller
                                );
                                miradorProvider.cambiarMarcaHorario();
                              },
                              id: 3,
                            )
                          )
                        ]
                      )
                    ),
                  ],
                )
              ),
            ],
          )
        ),
      ],
    );
  }
}

class ContactoSeccion extends StatelessWidget {
  const ContactoSeccion({super.key});

  @override
  Widget build(BuildContext context) {
    final miradorProvider = Provider.of<PanelMiradorProvider>(context);

    if (miradorProvider.addressController.text.isEmpty) {
      miradorProvider.addressController.text = miradorProvider.mirador.address;
    }
    if (miradorProvider.phoneController.text.isEmpty) {
      miradorProvider.phoneController.text = miradorProvider.mirador.phone;
    }
    if (miradorProvider.emailController.text.isEmpty) {
      miradorProvider.emailController.text = miradorProvider.mirador.email;
    }
    if (miradorProvider.instagramController.text.isEmpty) {
      miradorProvider.instagramController.text = miradorProvider.mirador.instagram;
    }
    if (miradorProvider.facebookController.text.isEmpty) {
      miradorProvider.facebookController.text = miradorProvider.mirador.facebook;
    }

    return Card(
        elevation: 3,
        color: Colors.grey[300],
        child: SizedBox(
          height: double.infinity,
          child: Stack(
            children: [
              const Padding(
                padding: EdgeInsets.all(15),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextContacto(label: 'Dirección:', id: 1),
                        TextContacto(label: 'Celular:', id: 2),
                        TextContacto(label: 'Correo electrónico:', id: 3),
                        TextContacto(label: 'Instagram:', id: 4),
                        TextContacto(label: 'Facebook:', id: 5),
                      ]
                  ),
                ),
              ),
              Positioned(
                  bottom: 10,
                  right: 10,
                  child: EditarWidget(
                    id: 1,
                    onEdit: () {
                      miradorProvider.cambiarMarcaContactoEdit();
                    },
                    onCheck: () {
                      miradorProvider.agregarValor(miradorProvider.addressController, 'address');
                      miradorProvider.agregarValor(miradorProvider.phoneController, 'phone');
                      miradorProvider.agregarValor(miradorProvider.emailController, 'email');
                      miradorProvider.agregarValor(miradorProvider.instagramController, 'instagram');
                      miradorProvider.agregarValor(miradorProvider.facebookController, 'facebook');
                      miradorProvider.cambiarMarcaContacto();
                    },
                  )
              )
            ],
          ),
        )
    );
  }
}

class ServiciosSeccion extends StatelessWidget {
  const ServiciosSeccion({super.key});

  @override
  Widget build(BuildContext context) {
    final miradorProvider = Provider.of<PanelMiradorProvider>(context);
    final sesionProvider = Provider.of<IniciarSesionProvider>(context);

    final lista_1 = miradorProvider.mirador.servicios;
    final lista_2 = sesionProvider.mirador.servicios;

    if (miradorProvider.serviciosController.text.isEmpty) {
      miradorProvider.serviciosController.text = miradorProvider.mirador.servicios.join('\n');
    }

    return Card(
      elevation: 3,
      color: Colors.grey[300],
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  flex: 1,
                  child: Text(
                    'Servicios:',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: miradorProvider.serviciosEdit
                      ? TextFieldServiciosMirador(
                        hintText:
                        lista_1.isEmpty && lista_2.isEmpty
                        ? 'Escriba cada servicio separado por un salto de linea.'
                        : lista_2.isEmpty ? lista_1.join('\n') : lista_2.join('\n'),
                        controller: miradorProvider.serviciosController,
                        focusNode: miradorProvider.serviciosFocusNode,
                      )
                      : lista_1.isEmpty && lista_2.isEmpty
                      ? const Text(
                        'Enliste los servicios que ofrece su mirador.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      )
                      : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: (lista_1.isEmpty ? lista_2 : lista_1)
                            .where((servicio) => servicio != null)
                            .map((servicio) => Text(
                          servicio!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        )
                        ).toList(),
                      ),
                    ),
                  )
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 10,
              right: 10,
              child: EditarWidget(
                onEdit: () {
                  miradorProvider.cambiarMarcaServiciosEdit();
                },
                onCheck: () {
                  miradorProvider.extraerServicios(miradorProvider.serviciosController);
                  miradorProvider.cambiarMarcaServicios();
                },
                id: 2,
              )
          )
        ],
      ),
    );
  }
}

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
      if (!mounted) return;

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