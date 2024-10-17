import 'dart:html';
import 'dart:ui_web' as ui;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/provider/screen_iniciar_sesion_provider.dart';
import 'package:pueblito_viajero/provider/panel_mirador_provider.dart';
import 'package:pueblito_viajero/utils/custom/custom_colors.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/widgets/textfield_mirador.dart';

class CardGoogleMaps extends StatefulWidget {
  final String src;
  final String name;
  final double width;
  final double height;

  const CardGoogleMaps({
    required this.src,
    this.width = 400,
    this.height = 300,
    super.key,
    required this.name,
  });

  @override
  _CardGoogleMapsState createState() => _CardGoogleMapsState();
}

class _CardGoogleMapsState extends State<CardGoogleMaps> {
  @override
  Widget build(BuildContext context) {
    final miradorProvider = Provider.of<PanelMiradorProvider>(context);
    final sesionProvider = Provider.of<IniciarSesionProvider>(context);

    ui.platformViewRegistry.registerViewFactory(
      'google-maps-iframe',
          (int viewId) => IFrameElement()
        ..width = widget.width.toString()
        ..height = widget.height.toString()
        ..src = widget.src
        ..style.border = 'none',
    );

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Card(
        elevation: 3,
        color: Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.only(right: 53, top: 10, bottom: 10, left: 10),
          child: Center(
            child: miradorProvider.mapaEdit
            ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFieldNombreMirador(
                  hintText: 'Link de mapa',
                  controller: miradorProvider.mapaController,
                  focusNode: miradorProvider.mapaFocusNode,
                  keyboardType: TextInputType.text,
                ),
              ],
            )
            : miradorProvider.mirador.mapa == '' && sesionProvider.mirador.mapa == ''
            ? const Icon(Icons.location_on_outlined,
              size: 50, color: AppColors.azulClaro)
            : ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: const HtmlElementView(viewType: 'google-maps-iframe'),
            ),
          ),
        ),
      ),
    );
  }
}
