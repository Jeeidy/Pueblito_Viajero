import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/provider/screen_start_provider.dart';
import 'package:pueblito_viajero/vistas/android/start/widgets/container_opciones.dart';
import 'package:pueblito_viajero/vistas/android/start/widgets/text_pueblito_viajero.dart';

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
    final startProvider = Provider.of<StartProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                const Expanded(
                  flex: 3,
                  child: TextPueblitoViajero(),
                ),
                Expanded(
                  flex: 8,
                  child: Stack(
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
                  ),
                ),
              ],
            ),
            Positioned(
              top: (MediaQuery.of(context).size.height * 0.33 / 12) + 20, // 3/12 of the screen height + 20 pixels
              left: (MediaQuery.of(context).size.width - 190) / 2, // Center horizontally
              child: Image.asset('assets/logo.png', height: 190),
            )
          ],
        ),
      ),
    );
  }
}
