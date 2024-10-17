import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/provider/screen_start_provider.dart';
import 'package:pueblito_viajero/utils/custom/custom_colors.dart';
import 'package:pueblito_viajero/vistas/android/start/widgets/container_opciones.dart';

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});
  @override
  _PantallaInicioState createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.transparent
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.blanco,
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    color: AppColors.blanco,
                  ),
                ),
                const Expanded(
                  flex: 3,
                  child: TextPueblitoViajero(),
                ),
                const Expanded(
                  flex: 8,
                  child: StackWidget()
                ),
              ],
            ),
            Positioned(
              top: (MediaQuery.of(context).size.height * 0.33 / 12) + 20,
              left: (MediaQuery.of(context).size.width - 190) / 2,
              child: Image.asset('assets/logo.png', height: 190),
            )
          ],
        ),
      ),
    );
  }
}

class StackWidget extends StatelessWidget {
  const StackWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final startProvider = Provider.of<StartProvider>(context);
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/start_img.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: GestureDetector(
                  onTap: () {
                    startProvider.irAPaginaInformacion(context);
                  },
                  child: const ContainerOpciones(
                    text: 'INFORMACIÓN',
                    imagePath: 'assets/información.png'
                  )
                ),
              )
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: GestureDetector(
                  onTap: () {
                    startProvider.irAPaginaServicios(context);
                  },
                  child: const ContainerOpciones(
                    text: 'SERVICIOS',
                    imagePath: 'assets/Servicios.png'
                  )
                ),
              )
            )
          ],
        )
      ],
    );
  }
}

class TextPueblitoViajero extends StatelessWidget {
  const TextPueblitoViajero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.verdeDivertido,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'PUEBLITO',
              style: GoogleFonts.inter(
                fontSize: 40,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 2,
                height: 1.03,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'VIAJERO',
              style: GoogleFonts.inter(
                fontSize: 40,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 2,
                height: 1.03,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
