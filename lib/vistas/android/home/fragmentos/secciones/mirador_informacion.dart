import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/widgets/card_mapa_stub.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../../modelos/mirador_modelo.dart';
import '../../../../../utils/custom/custom_colors.dart';
import '../../widgets/texto_movil_contacto.dart';

class InformacionMirador extends StatelessWidget {
  final MiradorModel mirador;

  const InformacionMirador({required this.mirador, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: MiradorTituloSliderDescripcion(mirador: mirador),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MiradorContacto(mirador: mirador),
                    const SizedBox(height: 15),
                    CardGoogleMaps(src: mirador.mapa, name: mirador.name),
                    const SizedBox(height: 15),
                    MiradorHorario(mirador: mirador),
                    MiradorServicios(mirador: mirador)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MiradorTituloSliderDescripcion extends StatelessWidget {
  final MiradorModel mirador;
  const MiradorTituloSliderDescripcion({required this.mirador, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Center(
            child: Text(
              mirador.name.toUpperCase(),
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: CarouselSlider(
            options: CarouselOptions(
              height: double.infinity,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 0.75,
            ),
            items: mirador.images.map((imageUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: const BoxDecoration(
                          color: AppColors.verdeDivertido,
                        ),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
            child: Center(
              child: Text(
                mirador.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black87,
                  height: 1,
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MiradorContacto extends StatelessWidget {
  final MiradorModel mirador;

  const MiradorContacto({required this.mirador, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: AppColors.verdeDivertido,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Center(
                child: Text(
                  'Información de contacto',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 2.3,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextoMovilContacto(
            dato: 'Dirección',
            texto: mirador.address,
            icono: const Icon(
              Icons.location_on_outlined,
              color: AppColors.verdeDivertido,
              size: 40,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Divider(
              color: Colors.grey.withOpacity(0.4),
              thickness: 0.8,
              height: 3,
            ),
          ),
          TextoMovilContacto(
            dato: 'Celular',
            texto: mirador.phone,
            icono: const Icon(
              Icons.phone,
              color: AppColors.verdeDivertido,
              size: 40,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Divider(
              color: Colors.grey.withOpacity(0.4),
              thickness: 0.8,
              height: 3,
            ),
          ),
          TextoMovilContacto(
            dato: 'Correo electrónico',
            texto: mirador.email,
            icono: const Icon(
              Icons.mail_outline_rounded,
              color: AppColors.verdeDivertido,
              size: 40,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Divider(
              color: Colors.grey.withOpacity(0.4),
              thickness: 0.8,
              height: 3,
            ),
          ),
          TextoMovilContacto(
            dato: 'Instagram',
            texto: mirador.instagram,
            icono: const Icon(
              Icons.camera_alt_outlined,
              color: AppColors.verdeDivertido,
              size: 40,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Divider(
              color: Colors.grey.withOpacity(0.4),
              thickness: 0.8,
              height: 3,
            ),
          ),
          TextoMovilContacto(
            dato: 'Facebook',
            texto: mirador.facebook,
            icono: const Icon(
              Icons.facebook_outlined,
              color: AppColors.verdeDivertido,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}

class MiradorMapa extends StatefulWidget {
  final MiradorModel mirador;

  const MiradorMapa({required this.mirador, super.key});

  @override
  _MiradorMapaState createState() => _MiradorMapaState();
}

class _MiradorMapaState extends State<MiradorMapa> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.mirador.mapa));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Card(
            color: AppColors.verdeDivertido,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Center(
                child: Text(
                  'Mapa',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 2.3,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.verdeDivertido,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: WebViewWidget(controller: _controller),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MiradorHorario extends StatelessWidget {
  final MiradorModel mirador;
  const MiradorHorario({super.key, required this.mirador});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Card(
            color: AppColors.verdeDivertido,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Center(
                child: Text(
                  'Horario',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 2.3,
                  ),
                ),
              ),
            ),
          ),
        ),
        const Text(
          'LUNES - VIERNES',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Text(
          mirador.hora[0]!,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(height: 10),
        const Text(
          'SABADOS - DOMINGOS - FESTIVOS',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Text(
          mirador.hora[1]!,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
      ],
    );
  }
}

class MiradorServicios extends StatelessWidget {
  final MiradorModel mirador;
  const MiradorServicios({super.key, required this.mirador});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Card(
            color: AppColors.verdeDivertido,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Center(
                child: Text(
                  'Servicios',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 2.3,
                  ),
                ),
              ),
            ),
          ),
        ),
        ...mirador.servicios.where((servicio) => servicio != null && servicio.isNotEmpty).map((servicio) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      color: AppColors.verdeDivertido,
                      size: 26,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      servicio!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Divider(
                    color: Colors.grey.withOpacity(0.4),
                    thickness: 0.8,
                    height: 3,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}