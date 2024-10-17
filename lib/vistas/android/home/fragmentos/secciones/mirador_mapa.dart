import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../../utils/custom/custom_colors.dart';
import '../../../../../modelos/mirador_modelo.dart';

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